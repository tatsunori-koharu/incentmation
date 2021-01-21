FactoryBot.define do
  factory :promotion do
    name            {Faker::Lorem.characters(number: 10)}
    content         {Faker::Lorem.sentences}
    category_id     {2}
    association :user
  end
end
