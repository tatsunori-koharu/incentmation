class ConsultationComment < ApplicationRecord
  belongs_to :consultation
  belongs_to :user
end
