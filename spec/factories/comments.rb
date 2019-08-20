FactoryBot.define do
  factory :comment do
    sequence(:comment_text) { Faker::Book.title }
    sequence(:author) { User.find(1) }
  end
end
