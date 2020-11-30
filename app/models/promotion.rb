class Promotion < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one_attached :move
  has_many :promotion_comments

  with_options presence: true do
    validates :name, length: { maximum: 40 }
    validates :content
  end
  
end
