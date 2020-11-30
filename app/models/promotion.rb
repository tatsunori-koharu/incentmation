class Promotion < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one_attached :move
  has_many :promotion_comments, dependent: :destroy
  has_many :promotion_likes, dependent: :destroy


  with_options presence: true do
    validates :name, length: { maximum: 40 }
    validates :content
  end

  def liked_by?(user)
    promotion_likes.where(user_id: user.id).exists?
  end

  
end
