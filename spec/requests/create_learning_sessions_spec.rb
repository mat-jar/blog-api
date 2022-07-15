require 'rails_helper'

RSpec.describe 'LearningSessions', type: :request do
  describe 'POST /create' do

    context 'with valid parameters' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }

      before do
        post '/api/v1/learning_sessions', params:
                        { learning_session: {
                          flashcard_set_id: new_flashcard_set.id,
                          user_id: new_user.id
                        } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns the flashcard_set_id' do
        expect(json['flashcard_set_id']).to eq(new_flashcard_set.id)
      end

      it 'returns the user_id' do
        expect(json['user_id']).to eq(new_user.id)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
    before do
      post '/api/v1/learning_sessions', params:
                      { learning_session: {
                        flashcard_set_id: "",
                        user_id: ""
                      } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
    end
      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

      context 'without logged user' do
        let!(:new_user) { FactoryBot.create(:user) }
        let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }

        before do
          post '/api/v1/learning_sessions', params:
                          { learning_session: {
                            flashcard_set_id: new_flashcard_set.id,
                            user_id: new_user.id
                          } }
        end
        it 'returns a demand to log in or sign up' do
          expect(response.body).to eq("You need to log in or sign up before continuing.")
        end
        it 'returns an unauthorized status' do
          expect(response).to have_http_status(:unauthorized)
        end
    end
  end
end
