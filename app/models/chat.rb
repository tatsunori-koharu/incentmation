class Chat < ApplicationRecord
  has_many :users, through: :user_chats
  has_many :user_chats
end
