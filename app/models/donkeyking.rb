class Donkeyking < ApplicationRecord
  belongs_to :user

  validates :tweet, presence: true

  def delete_time
    deleted_at = Time.now + 60 * 60
  end
  
end
