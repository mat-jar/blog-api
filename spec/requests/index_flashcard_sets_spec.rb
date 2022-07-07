require 'rails_helper'


RSpec.describe 'FlashcardSets', type: :request do
  describe 'GET /index' do

    context 'with user and their flashcard_set' do
      include_context "sign_up_and_sign_in_user"

      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }

      before do

        get '/api/v1/flashcard_sets', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end

      it 'returns flashcard set' do

        expect(json[0]).to eq(JSON.parse(new_flashcard_set.to_json))

      end
    end

    context 'with user and not their flashcard_set' do
      include_context "sign_up_and_sign_in_user"

      let!(:new_user2) { FactoryBot.create(:user) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user2.id) }

      before do

        get '/api/v1/flashcard_sets', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns empty array' do
        expect(response.body).to eq("[]")
      end

    end



  end
end
