class Consultation < ApplicationRecord
  belongs_to :user
  has_many :consultation_comments
  has_one :consultation_fix
  has_many_attached :images
  has_one_attached :move

  with_options presence: true do
    validates :title,  length: { maximum: 40 }
    validates :content
  end
  
end
