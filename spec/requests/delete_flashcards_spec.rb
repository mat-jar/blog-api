require 'rails_helper'

RSpec.describe 'Flashcards', type: :request do
  describe "DELETE /destroy" do
    context 'with user and flashcard from their flashcard_set' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
    let!(:new_flashcard) { FactoryBot.create(:flashcard, flashcard_set_id: new_flashcard_set.id) }

      before do
        delete "/api/v1/flashcards/#{new_flashcard.id}", headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns status no_content - code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with user and flashcard not from their flashcard_set' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_user2) { FactoryBot.create(:user)}
    let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user2.id) }
    let!(:new_flashcard) { FactoryBot.create(:flashcard, flashcard_set_id: new_flashcard_set.id) }


      before do
        delete "/api/v1/flashcards/#{new_flashcard.id}", headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns status forbidden - code 403' do
        expect(response).to have_http_status(:forbidden)
      end
    end

  end
end
