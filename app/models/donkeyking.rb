class Donkeyking < ApplicationRecord
  belongs_to :user

  validates :tweet, presence: true


end
