require 'rails_helper'

RSpec.describe 'UserSentenceSets', type: :request do
  describe "DELETE /destroy" do
    context 'with user and their user_sentence_set' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }

      before do
        delete "/api/v1/user_sentence_sets/#{new_user_sentence_set.id}", headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns status no_content - code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with user and not their user_sentence_set' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_user2) { FactoryBot.create(:user)}
    let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user2.id) }

      before do
        delete "/api/v1/user_sentence_sets/#{new_user_sentence_set.id}", headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns status forbidden - code 403' do
        expect(response).to have_http_status(:forbidden)
      end
    end

  end
end
