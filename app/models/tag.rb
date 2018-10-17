class Tag < ApplicationRecord
  validates_presence_of :title
  validates_length_of :title, in: 1..55
end
