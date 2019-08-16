# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Task.destroy_all
Comment.destroy_all
Admin.destroy_all
User.destroy_all
4.times do
  user = User.new(
      :email                 => Faker::Internet.free_email,
      :password              => "123456",
      :password_confirmation => "123456"
  )
  user.save!
end

2.times do
  admin = Admin.create(
      email: Faker::Internet.free_email,
      :password              => "qwerty",
      :password_confirmation => "qwerty"
      )
  admin.save!
end

10.times do |i|
  story = Story.create(
      subject: Faker::Job.title,
      status: Random.rand(4),
      description: Faker::Job.field,
      admin_id: 1,
      user_id: 1,
      id: i + 1,
      )
  story.save!

  issue = Issue.create(
      subject: Faker::Job.title,
      status: Random.rand(4),
      description: Faker::Job.field,
      admin_id: 2,
      user_id: 2,
      id: i + 11,
      )
  issue.save!
end

20.times do |i|
  comment = Comment.create(
      comment_text: Faker::Book.title,
      author: User.find(1),
      id: i + 21,
      )
  comment.save!

  comment = Comment.create(
      comment_text: Faker::Book.title,
      reply_id: i,
      author: User.find(2),
      id: i + 1,
      )
  comment.save!
end