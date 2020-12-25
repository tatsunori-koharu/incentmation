class ChatMessagesController < ApplicationController

  def create
    chat_message = ChatMessage.create(chat_message_params
      redirect_to "/chats/#{chat_message.chat.id}"
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:message).merge(user_id: current_user.id, chat_id: params[:chat_id])
  end
end