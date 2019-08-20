FactoryBot.define do
  factory :user do
    sequence(:email) { Faker::Internet.free_email }
    password { "123456" }
  end
end
