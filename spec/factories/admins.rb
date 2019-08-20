FactoryBot.define do
  factory :admin do
    sequence(:email) { Faker::Internet.free_email }
    password { "qwerty" }
  end
end
