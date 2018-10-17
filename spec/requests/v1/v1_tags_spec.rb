require 'rails_helper'

RSpec.describe 'V1::Tags', type: :request do
  let!(:tasks) { FactoryBot.create_list(:task_with_tags, 5) }

  describe 'GET /api/v1/tags' do
    before { get v1_tags_url }

    it 'should return 200' do
      expect(response).to have_http_status(200)
    end

    context 'root level' do
      it { expect(json).to have_json_path('data')  }
    end

    context 'root level data attributes' do
      it { expect(json).to have_json_path('data/0/attributes/title')  }
    end

    context 'root level data relationships' do
      it { expect(json).to have_json_path('data/0/relationships/tasks/data')  }
      it { expect(parsed_json['data'][0]['relationships']['tasks']['data'].size).to be > 0 }
    end
  end


  describe 'POST /api/v1/tags' do
    let(:valid_attributes) { {"data":{"type":"undefined","id":"undefined","attributes":{"title":"Someday"}}} }

    context 'create task with valid attributes' do
      before { post v1_tags_url, params: valid_attributes }

      it 'should return 201' do
        expect(response).to have_http_status(201)
      end

      it 'should return created tag' do
        expect(json).to have_json_path('data/id')
        expect(json).to have_json_path('data/attributes/title')
        expect(json).to have_json_path('data/relationships/tasks/data')
      end

      it 'should create tag' do
        tag = Tag.find(parsed_json['data']['id'])
        expect(tag.title).to eq('Someday')
      end
    end
  end


  describe 'PATCH /api/v1/tag' do
    let(:valid_attributes) { {"data":{"type":"tasks","id":"2","attributes":{"title":"Updated Tag Title"}}} }

    context 'update task with valid attributes' do
      before { patch v1_tag_url(2), params: valid_attributes }

      it 'should return 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return updated tag' do
        expect(json).to have_json_path('data/id')
        expect(json).to have_json_path('data/attributes/title')
        expect(json).to have_json_path('data/relationships/tasks/data')
      end

      it 'should update tag' do
        task = Tag.find(2)
        expect(task.title).to eq('Updated Tag Title')
      end
    end
  end


  describe 'DELETE /api/v1/tag' do
    before { Task.first.update(tags: [Tag.first]) }
    before { delete v1_tag_url(1) }

    it 'should return 204' do
      expect(response).to have_http_status(204)
    end

    it 'should remove relation from Task' do
      expect(Task.first.tags.size).to eq(0)
    end
  end
end
