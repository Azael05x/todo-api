require 'rails_helper'

RSpec.describe 'V1::Tasks', type: :request do
  let!(:tasks) { FactoryBot.create_list(:task_with_tags, 5) }

  describe 'GET /api/v1/tasks' do
    before { get v1_tasks_url }

    it 'should return 200' do
      expect(response).to have_http_status(200)
    end

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


  describe 'POST /api/v1/tasks' do
    let(:valid_attributes) { {"data":{"type":"undefined","id":"undefined","attributes":{"title":"Do Homework"}}} }

    context 'create task with valid attributes' do
      before { post v1_tasks_url, params: valid_attributes }

      it 'should return 201' do
        expect(response).to have_http_status(201)
      end

      it 'should return created task' do
        expect(json).to have_json_path('data/id')
        expect(json).to have_json_path('data/attributes/title')
        expect(json).to have_json_path('data/relationships/tags/data')
      end

      it 'should create task' do
        task = Task.find(parsed_json['data']['id'])
        expect(task.title).to eq('Do Homework')
      end
    end
  end


  describe 'PATCH /api/v1/tasks' do
    let(:valid_attributes) { {"data":{"type":"tasks","id":"2","attributes":{"title":"Updated Task Title"}}} }

    context 'update task with valid attributes' do
      before { patch v1_task_url(2), params: valid_attributes }

      it 'should return 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return updated task' do
        expect(json).to have_json_path('data/id')
        expect(json).to have_json_path('data/attributes/title')
        expect(json).to have_json_path('data/relationships/tags/data')
      end

      it 'should update task' do
        task = Task.find(2)
        expect(task.title).to eq('Updated Task Title')
      end
    end
  end
end
