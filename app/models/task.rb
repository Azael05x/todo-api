class Task < ApplicationRecord
  validates_presence_of :title
  validates_length_of :title, in: 1..255
end
