FactoryBot.define do
  factory :consultation do
    title           {Faker::Lorem.characters(number: 10)}
    content         {Faker::Lorem.sentence}
    category_id     {2}
    association :user
  end
end
