require 'rails_helper'

RSpec.describe 'FlashcardSets', type: :request do
  describe "DELETE /destroy" do
    context 'with user and their flashcard_set' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }

      before do
        delete "/api/v1/flashcard_sets/#{new_flashcard_set.id}", headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns status no_content - code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with user and not their flashcard_set' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_user2) { FactoryBot.create(:user)}
    let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user2.id) }

      before do
        delete "/api/v1/flashcard_sets/#{new_flashcard_set.id}", headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns status forbidden - code 403' do
        expect(response).to have_http_status(:forbidden)
      end
    end

  end
end
