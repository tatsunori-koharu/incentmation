class Promotion < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one_attached :move

  with_options presence: true do
    validates :name, length: { maximum: 40 }
    validates :content
  end
  
end
