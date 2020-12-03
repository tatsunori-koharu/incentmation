class ChatMessage < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  validates :message, presence: true
end
