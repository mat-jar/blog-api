require 'rails_helper'


RSpec.describe 'Flashcards', type: :request do
  describe 'GET /index' do

    context 'with user and flashcards from their flashcard_set' do
      include_context "sign_up_and_sign_in_user"

      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
      let!(:new_flashcard_set_settings_panel) { FlashcardSetSettingsPanel.create(flashcard_set_id: new_flashcard_set.id, user_id: new_user.id) }
      let!(:new_flashcards) {FactoryBot.create_list(:flashcard, 10, flashcard_set_id: new_flashcard_set.id )}

      before do

        get "/api/v1/flashcard_sets/#{new_flashcard_set.id}/flashcards", headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns flashcards and settings panel' do
        expect(json['flashcards']).to eq(JSON.parse(new_flashcards.to_json))
        expect(json['flashcard_set_settings_panel'][0]).to eq(JSON.parse(new_flashcard_set_settings_panel.to_json))
      end

      it 'returns all flashcards' do
        #debugger
        expect(json['flashcards'].size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
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
