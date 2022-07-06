require 'rails_helper'


RSpec.describe 'Flashcards', type: :request do
  describe 'POST /create' do


    context 'with valid parameters and flashcard_set' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
    let!(:new_flashcard) { FactoryBot.build(:flashcard) }

      before do
        post "/api/v1/flashcard_sets/#{new_flashcard_set.id}/flashcards", params:
                          { flashcard: {
                            front_text: new_flashcard.front_text,
                            back_text: new_flashcard.back_text
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns the front_text' do
        expect(json['front_text']).to eq(new_flashcard.front_text)
      end

      it 'returns the back_text' do
        expect(json['back_text']).to eq(new_flashcard.back_text)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end



    context 'with invalid parameters and flashcard_set' do
      include_context "sign_up_and_sign_in_user"
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
      before do
        post "/api/v1/flashcard_sets/#{new_flashcard_set.id}/flashcards", params:
                          { flashcard: {
                            front_text: '',
                            back_text: ''
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end
end
