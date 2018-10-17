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


  describe 'Accessor: Tag String' do
    let!(:tags) { create_list(:tag, 2) }

    it 'should assign new or use existing tags' do
      task = Task.create({ title: 'Test', tag_strings: [ Tag.first.title, 'NewTag' ] })
      expect(task.tags.first.title).to eq(Tag.first.title)
      expect(task.tags.second.title).to eq('NewTag')
    end
  end
end
