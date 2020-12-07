class ChatsController < ApplicationController
  
  def new
    @chat = Chat.new
    @chats = Chat.all
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to chat_path(@chat.id)
    else
      render :new
    end
  end

  def show
    @chat_message = ChatMessage.new
    @chat = Chat.find(params[:id])
    @chat_messages = @chat.chat_messages.includes(:user)
  end

  def update
    @chat = Chat.find(params[:id])
    if @chat.update(chat_params)
      redirect_to chat_path(@chat.id)
    else
      render :new
    end
  end

  private

  def chat_params
    params.require(:chat).permit(user_ids: [])
  end

  def other_user
    other_user = User.where.not(id: current_user.id)
  end

end
