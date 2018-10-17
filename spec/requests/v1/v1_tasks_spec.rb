require 'rails_helper'

RSpec.describe 'V1::Tasks', type: :request do
  describe 'GET /api/v1/tasks' do
    before { get v1_tasks_url }

    it 'works' do
      expect(json).not_to be_nil
    end
  end
end
