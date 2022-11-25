require 'rails_helper'


RSpec.describe 'UserSentences', type: :request do
  describe 'GET /index' do

    context 'with user and user_sentences from their user_sentence_set' do
      include_context "sign_up_and_sign_in_user"

      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }
      let!(:new_user_sentences) {FactoryBot.create_list(:user_sentence, 10, user_sentence_set_id: new_user_sentence_set.id )}

      before do

        get "/api/v1/user_sentence_sets/#{new_user_sentence_set.id}/user_sentences", headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns user_sentences' do
        expect(json['user_sentences']).to eq(JSON.parse(new_user_sentences.to_json))

      end

      it 'returns all user_sentences' do
        expect(json['user_sentences'].size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with user and not their user_sentence_set' do
      include_context "sign_up_and_sign_in_user"

      let!(:new_user2) { FactoryBot.create(:user) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user2.id) }

      before do

        get '/api/v1/user_sentence_sets', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns empty array' do
        expect(response.body).to eq("[]")
      end

    end



  end
end
