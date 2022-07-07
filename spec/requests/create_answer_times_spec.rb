require 'rails_helper'

RSpec.describe 'AnswerTimes', type: :request do
  describe 'POST /create' do

    context 'with valid parameters' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
    let!(:new_flashcard) { FactoryBot.create(:flashcard, flashcard_set_id: new_flashcard_set.id) }
    let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_user.id) }
    let!(:new_answer_time) { FactoryBot.build(:answer_time, flashcard_id: new_flashcard.id, learning_session_id: new_learning_session.id) }

      before do
        post '/api/v1/answer_times', params:
                          { answer_time: {
                            learning_session_id: new_answer_time.learning_session_id,
                            flashcard_id: new_answer_time.flashcard_id,
                            round: new_answer_time.round,
                            time_millisecond: new_answer_time.time_millisecond
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns the learning_session_id' do
        expect(json['learning_session_id']).to eq(new_answer_time.learning_session_id)
      end

      it 'returns the flashcard_id' do
        expect(json['flashcard_id']).to eq(new_answer_time.flashcard_id)
      end

      it 'returns the round' do
        expect(json['round']).to eq(new_answer_time.round)
      end

      it 'returns the time_millisecond' do
        expect(json['time_millisecond']).to eq(new_answer_time.time_millisecond)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
    include_context "sign_up_and_sign_in_user"
      before do
        post '/api/v1/answer_times', params:
                          { answer_time: {
                            learning_session_id: '',
                            flashcard_id: '',
                            round: '',
                            time_millisecond: ''
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end
      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

      context 'without logged user' do
        let!(:new_user) { FactoryBot.create(:user)}
        let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
        let!(:new_flashcard) { FactoryBot.create(:flashcard, flashcard_set_id: new_flashcard_set.id) }
        let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_user.id) }
        let!(:new_answer_time) { FactoryBot.build(:answer_time, flashcard_id: new_flashcard.id, learning_session_id: new_learning_session.id) }


        before do
          post '/api/v1/answer_times', params:
                            { answer_time: {
                              learning_session_id: new_answer_time.learning_session_id,
                              flashcard_id: new_answer_time.flashcard_id,
                              round: new_answer_time.round,
                              time_millisecond: new_answer_time.time_millisecond
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
