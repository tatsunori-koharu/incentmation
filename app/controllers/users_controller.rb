class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @chats = Chat.all
  end
end
