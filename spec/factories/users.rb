FactoryBot.define do
  factory :user do
    nickname               {Faker::Name.name}
    email                  {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password               {password}
    password_confirmation  {password}
    location_id            { "2" }
    department_id          {2}
    bed                    {22}
    service_years          {33}
    license                {'医師免許'}
    company                {'ニコニコ株式会社'}
  end
end
