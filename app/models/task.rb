class Task < ApplicationRecord
  attr_accessor :tag_strings

  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  validates_presence_of :title
  validates_length_of :title, in: 1..255

  before_save :set_tag_strings, if: -> { self.tag_strings.present? }


  private

    def set_tag_strings
      tags = self.tag_strings.map do |title|
        Tag.where(title: title).first_or_create
      end
      self.tags = tags
    end
end
