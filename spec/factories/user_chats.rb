FactoryBot.define do
  factory :user_chat do
    association :user
    association :chat
  end
end
