class ChatMessagesController < ApplicationController

  def create
    chat_message = ChatMessage.create(chat_message_params)
    # if @chat_message.save
      redirect_to "/chats/#{chat_message.chat.id}"
      # render json:{ chat_message: @chat_message}
    # end
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:message).merge(user_id: current_user.id, chat_id: params[:chat_id])
  end
end