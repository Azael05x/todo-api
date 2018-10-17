require 'rails_helper'

RSpec.describe 'V1::Tasks', type: :request do
  let!(:tasks) { FactoryBot.create_list(:task_with_tags, 5) }

  describe 'GET /api/v1/tasks' do
    before { get v1_tasks_url }

    context 'root level' do
      it { expect(json).to have_json_path('data')  }
      it { expect(json).to have_json_path('included')  }
    end

    context 'root level data attributes' do
      it { expect(json).to have_json_path('data/0/attributes/title')  }
    end

    context 'root level data relationships' do
      it { expect(json).to have_json_path('data/0/relationships/tags/data')  }
    end

    context 'root level included attributes' do
      it { expect(json).to have_json_path('included/0/attributes/title')  }
    end

    context 'root level included relationships' do
      it { expect(json).to have_json_path('included/0/relationships/tasks/data')  }
    end
  end
end
