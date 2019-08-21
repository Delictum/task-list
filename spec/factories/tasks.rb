FactoryBot.define do
  factory :task do
    sequence(:subject) { Faker::Job.title }
    sequence(:status) { Random.rand(4)}
    sequence(:description) { Faker::Job.field }
    sequence(:admin_id) { 1 }
    sequence(:user_id) { 1 }
    sequence(:type) { 'Story' }
  end
end
