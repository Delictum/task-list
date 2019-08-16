class Task < ApplicationRecord
  has_and_belongs_to_many :comments

  validates :subject, presence: true, length: { in: 2..100 }
  validates :description, presence: true, length: { in: 2..300 }

  private
  def set_last_task
    last_task = self.as_json(include: [:comments, :user, :admin])
    comment.update(last_task: last_task)
  end
end
