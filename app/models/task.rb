class Task < ApplicationRecord
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  validates_presence_of :title
  validates_length_of :title, in: 1..255
end
