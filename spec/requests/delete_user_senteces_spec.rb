require 'rails_helper'

RSpec.describe 'UserSentences', type: :request do
  describe "DELETE /destroy" do
    context 'with user and user_sentence from their user_sentence_set' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }
    let!(:new_user_sentence) { FactoryBot.create(:user_sentence, user_sentence_set_id: new_user_sentence_set.id) }

      before do
        delete "/api/v1/user_sentences/#{new_user_sentence.id}", headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns status no_content - code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with user and user_sentence not from their user_sentence_set' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_user2) { FactoryBot.create(:user)}
    let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user2.id) }
    let!(:new_user_sentence) { FactoryBot.create(:user_sentence, user_sentence_set_id: new_user_sentence_set.id) }


      before do
        delete "/api/v1/user_sentences/#{new_user_sentence.id}", headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns status forbidden - code 403' do
        expect(response).to have_http_status(:forbidden)
      end
    end

  end
end
