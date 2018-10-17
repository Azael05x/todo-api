require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Associations' do
    it { should have_many(:tags).through(:task_tags) }
    it { should have_many(:task_tags).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:title) }

    it { should validate_length_of(:title).is_at_least(1).is_at_most(255) }
  end
end
