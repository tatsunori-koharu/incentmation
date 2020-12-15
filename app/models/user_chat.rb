class UserChat < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  validates :chat, :uniqueness => [:scope => :user_ids]
end
