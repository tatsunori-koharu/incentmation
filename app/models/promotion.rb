class Promotion < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one_attached :move
  has_many :promotion_comments, dependent: :destroy
  has_many :promotion_likes, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category


  with_options presence: true do
    validates :name, length: { maximum: 40 }
    validates :content
  end

  def liked_by?(user)
    promotion_likes.where(user_id: user.id).exists?
  end

  def self.search(search)
    if search != ""
      Promotion.where('content LIKE(?)', "%#{search}%")
    else
      puts "検索結果はありません"
    end
  end

  
end
