require 'rails_helper'


RSpec.describe 'LearningSessions', type: :request do
  describe 'GET /index' do

    context 'with user and their learning_sessions' do
      include_context "sign_up_and_sign_in_user"

      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
      let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_user.id) }

      before do

        get '/api/v1/learning_sessions', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end

      it 'returns learning_sessions' do
        expect(json[0]).to eq(JSON.parse(new_learning_session.to_json))

      end
    end

    context 'with user and not their learning_sessions' do
      include_context "sign_up_and_sign_in_user"

      let!(:new_user2) { FactoryBot.create(:user)}
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user2.id) }
      let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_user2.id) }

      before do

        get '/api/v1/learning_sessions', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns empty array' do
        expect(response.body).to eq("[]")
      end

    end

  end
end
