FactoryBot.define do
  factory :article do
    title    {Faker::Lorem.characters(number: 10)}
    content  {Faker::Lorem.sentences}
    association :user
  end
end
