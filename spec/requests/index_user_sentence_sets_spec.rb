require 'rails_helper'


RSpec.describe 'UserSentenceSets', type: :request do
  describe 'GET /index' do

    context 'with user and their user_sentence_set' do
      include_context "sign_up_and_sign_in_user"

      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }

      before do

        get '/api/v1/user_sentence_sets', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end

      it 'returns user_sentence set' do

        expect(json[0]).to eq(JSON.parse(new_user_sentence_set.to_json))

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
