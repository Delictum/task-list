class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks
  has_many :comments, as: :author

  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  def send_task_modified
    SendModifiedTaskEmailJob.perform_now(id)
  end
end
