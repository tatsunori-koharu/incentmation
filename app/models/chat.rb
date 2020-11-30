class Chat < ApplicationRecord
  has_many :user, through: :user_chats
  has_many :user_chats
end
