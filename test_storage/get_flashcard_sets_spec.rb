require 'rails_helper'

RSpec.describe 'FlashcardSets', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:flashcard_set, 10)
      get '/api/v1/flashcard_sets'
    end

    it 'returns all flashcard_sets' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
