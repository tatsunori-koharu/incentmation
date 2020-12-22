class Consultation < ApplicationRecord
  belongs_to :user
  has_many :consultation_comments, dependent: :destroy
  has_many :consultation_fixes, dependent: :destroy
  has_many_attached :images
  has_one_attached :move

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do
    validates :title,  length: { maximum: 40 }
    validates :content
  end

  def liked_by?(user)
    consultation_fixes.where(user_id: user.id).exists?
  end
  
end
