class PromotionComment < ApplicationRecord
  belongs_to :promotion 
  belongs_to :user

  validates :promotion, presences: true
end
