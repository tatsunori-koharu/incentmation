class ChatMessagesController < ApplicationController

  def index
    @chat_messages = ChatMessages.all
    @chat = Chat.find(params[:chat_id])
  end

  def new
    @chat_message = ChatMessage.new
  end

  def create
    @chat_message = ChatMessage.new(chat_message_params)
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:message).merge(user_id: current_user.id, chat_id: params[:chat_id])
  end
end

