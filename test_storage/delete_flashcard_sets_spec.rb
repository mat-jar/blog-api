require 'rails_helper'

RSpec.describe 'FlashcardSets', type: :request do
  describe "DELETE /destroy" do
    let!(:flashcard_set) { FactoryBot.create(:flashcard_set) }

    before do
      delete "/api/v1/flashcard_set/#{flashcard_set.id}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
