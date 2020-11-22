class Article < ApplicationRecord
  belongs_to :user
  has_many_attached :images


  with_options presence: true do
    validates :title
    validates :content
  end
end
