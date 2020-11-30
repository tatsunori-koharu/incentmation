class ChatsController < ApplicationController
  
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
  end

  private

  def chat_params
    params.permit(user_ids: [])
  end
end
