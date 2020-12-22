class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @chats = Chat.all
    users = User.all
    chats = Chat.all 
    chats.each do |chat|
      if chat.users.ids.include?(@user.id) && chat.users.ids.include?(current_user.id)
        @chat_num = chat.id
      else
        @chat_num = 85
      end
    end
  end
end
