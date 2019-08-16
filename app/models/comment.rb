class Comment < ApplicationRecord
  belongs_to :author, polymorphic: true

  has_many :common, class_name: "Comment",
           foreign_key: "reply_id"

  belongs_to :reply, class_name: "Comment", optional: true

  has_and_belongs_to_many :tasks
end
