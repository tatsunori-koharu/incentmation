class Article < ApplicationRecord
  belongs_to :user
  has_many :article_comments, dependent: :destroy
  has_many :article_likes, dependent: :destroy
  has_many_attached :images
  has_one_attached :move

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category


  with_options presence: true do
    validates :title,  length: { maximum: 40 }
    validates :content
  end

  def liked_by?(user)
    article_likes.where(user_id: user.id).exists?
  end

  def self.search(search)
    if search != ""
      Article.where('content LIKE(?)', "%#{search}%")
    else
      []
    end
  end

end
