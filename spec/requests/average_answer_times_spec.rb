require 'rails_helper'

RSpec.describe 'AnswerTimes', type: :request do
  describe 'POST /create' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
    let!(:new_flashcard) { FactoryBot.create(:flashcard, flashcard_set_id: new_flashcard_set.id) }
    let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_user.id) }
    let!(:new_answer_time1) { FactoryBot.create(:answer_time, flashcard_id: new_flashcard.id, learning_session_id: new_learning_session.id, time_millisecond: 1000) }
    let!(:new_answer_time2) { FactoryBot.create(:answer_time, flashcard_id: new_flashcard.id, learning_session_id: new_learning_session.id, time_millisecond: 3000) }
    let!(:new_answer_time3) { FactoryBot.create(:answer_time, flashcard_id: new_flashcard.id, learning_session_id: new_learning_session.id, time_millisecond: 8000) }

    describe 'user_average' do
      context 'given a user_id' do

        before do
          post '/api/v1/answer_times/user_average', params:
                            { answer_time: {
                              user_id: new_user.id
                            } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
        end

        it 'returns the average_answer_time' do
          expect(json['average_answer_time']).to eq(4000)
        end
      end

      context 'given an invalid parameter' do

        before do
          post '/api/v1/answer_times/user_average', params:
                            { answer_time: {
                              user: new_user.id
                            } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
        end

        it 'returns an unprocessable entity status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

    end

    describe 'flashcard_set_average' do
      context 'given a flashcard_set_id' do

        before do
          post '/api/v1/answer_times/flashcard_set_average', params:
                            { answer_time: {
                              flashcard_set_id: new_flashcard_set.id
                            } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
        end

        it 'returns the average_answer_time' do
          expect(json['average_answer_time']).to eq(4000)
        end
      end

      context 'given an invalid parameter' do

        before do
          post '/api/v1/answer_times/flashcard_set_average', params:
                            { answer_time: {
                              user: new_user.id
                            } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
        end

        it 'returns an unprocessable entity status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

    end

    describe 'word_average' do
      context 'given a word and front_text' do

        before do
          new_flashcard.update!(front_text: "koza")
          post '/api/v1/answer_times/word_average', params:
                            { answer_time: {
                              word: "koza"
                            } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
        end

        it 'returns the average_answer_time' do
          expect(json['average_answer_time']).to eq(4000)
        end
      end

      context 'given an invalid parameter' do

        before do
          post '/api/v1/answer_times/word_average', params:
                            { answer_time: {
                              user: new_user.id
                            } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
        end

        it 'returns an unprocessable entity status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

    end

    describe 'word_average' do
      context 'given a word and back_text' do

        before do
          new_flashcard.update!(back_text: "koza")
          post '/api/v1/answer_times/word_average', params:
                            { answer_time: {
                                word: "koza"
                            } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
        end

        it 'returns the average_answer_time' do
          expect(json['average_answer_time']).to eq(4000)
        end
      end

      context 'given an invalid parameter' do

        before do
          post '/api/v1/answer_times/word_average', params:
                            { answer_time: {
                              user: new_user.id
                            } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
        end

        it 'returns an unprocessable entity status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

    end

    describe 'learning_session_average' do
      context 'given a learning_session_id' do

        before do
          post '/api/v1/answer_times/learning_session_average', params:
                            { answer_time: {
                              learning_session_id: new_learning_session.id
                            } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
        end

        it 'returns the average_answer_time' do
          expect(json['average_answer_time']).to eq(4000)
        end
      end

      context 'given an invalid parameter' do

        before do
          post '/api/v1/answer_times/learning_session_average', params:
                            { answer_time: {
                              user: new_user.id
                            } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
        end

        it 'returns an unprocessable entity status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

    end

  end
end
