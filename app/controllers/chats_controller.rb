class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :update]
  before_action :set_all, only: [:new, :show]

  def new
    @chat = Chat.new
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
    @chat_messages = @chat.chat_messages.includes(:user)
  end

  def update
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

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def set_all
    @chats = Chat.all
  end

end

