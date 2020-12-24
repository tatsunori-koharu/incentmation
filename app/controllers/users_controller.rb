class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @chats = Chat.all
    users = User.all
    chats = Chat.all 
    chat_num = chats.find do |chat|
      chat.users.ids.include?(@user.id) && chat.users.ids.include?(current_user.id)
    end
    if chat_num == nil
      @chat_num = nil
    else
      @chat_num = chat_num[:id]
    end
  end
end
