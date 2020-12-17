class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @chats = Chat.all
    user_chats = UserChat.all
  end
end
