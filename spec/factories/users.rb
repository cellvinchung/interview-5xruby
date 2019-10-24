FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { "demo@example.com" }
    password { "123456" }
  end
end
