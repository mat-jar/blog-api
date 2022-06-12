require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:article, 10)
      get '/api/v1/articles'
    end

    it 'returns all articles' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
