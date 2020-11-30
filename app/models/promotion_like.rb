class PromotionLike < ApplicationRecord
  belongs_to :user
  belongs_to :promotion
end
