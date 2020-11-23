class Article < ApplicationRecord
  belongs_to :user
  has_many :article_comments
  has_many_attached :images
  has_one_attached :move


  with_options presence: true do
    validates :title
    validates :content
  end
end
