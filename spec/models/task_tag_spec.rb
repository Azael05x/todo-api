require 'rails_helper'

RSpec.describe TaskTag, type: :model do
  describe 'Associations' do
    it { should belong_to(:task) }
    it { should belong_to(:tag) }
  end
end
