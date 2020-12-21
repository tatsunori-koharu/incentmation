class UsersController < ApplicationController
  def show
    # users = Chat.find(params[:id]).user_chats
    @user = User.find(params[:id])
    @chats = Chat.all
    users = User.all
  end
end
