class Tag < ApplicationRecord
  has_many :task_tags, dependent: :destroy
  has_many :tasks, through: :task_tags

  validates_presence_of :title
  validates_length_of :title, in: 1..55
end
