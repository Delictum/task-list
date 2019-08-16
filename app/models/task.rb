class Task < ApplicationRecord
  has_and_belongs_to_many :comments
end
