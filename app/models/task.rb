class Task < ApplicationRecord
  has_and_belongs_to_many :comments

  validates :subject, presence: true, length: { in: 2..100 }
  validates :description, presence: true, length: { in: 2..300 }
  validates_format_of :status, with: /^([0-3])$/, :multiline => true

  before_save :default_values
  def default_values
    self.status ||= 0 # note self.status = 'P' if self.status.nil? might be safer (per @frontendbeauty)
  end

  private
  def set_last_task
    last_task = self.as_json(include: [:comments, :user, :admin])
    comment.update(last_task: last_task)
  end
end
