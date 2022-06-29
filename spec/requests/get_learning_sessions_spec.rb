require 'rails_helper'


RSpec.describe 'LearningSessions', type: :request do
  describe 'GET /index' do

    context 'with teacher and their student' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_student.id) }
      let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_student.id) }


      before do

        debugger
        get '/api/v1/learning_sessions', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end

      it 'returns students learning_session' do
        expect(response.body).to eq(:new_learning_session)
      end

    end

    context 'with teacher and not their student' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_teacher2) { FactoryBot.create(:user, role: :teacher)}
      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher2.id) }
        let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_student.id) }
        let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_student.id) }

      before do

        get '/api/v1/learning_sessions', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns empty array' do
        expect(response.body).to eq("[]")
      end

    end
  end
end
