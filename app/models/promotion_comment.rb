class PromotionComment < ApplicationRecord
  belongs_to :promotion 
  belongs_to :user

  validates :comment, presence: true
end
