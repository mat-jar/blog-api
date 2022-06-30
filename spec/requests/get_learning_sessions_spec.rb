require 'rails_helper'


RSpec.describe 'LearningSessions', type: :request do
  describe 'GET /index' do

    context 'with teacher and their student' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_student.id) }
      let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_student.id) }


      before do

        get '/api/v1/learning_sessions', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end

      it 'returns learning_sessions of the students who belongs to this teacher' do
        #expect(response.body).to eq(new_learning_session.to_json)
        expect(json[0]).to eq(JSON.parse(new_learning_session.to_json))


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

    context 'with student' do
      include_context "sign_up_and_sign_in_student"
        let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_student.id) }
        let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_student.id) }

      before do

        get '/api/v1/learning_sessions', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns their learning_sessions' do
        expect(json[0]).to eq(JSON.parse(new_learning_session.to_json))
      end

    end

    context 'with student and learning_session of another student' do
      include_context "sign_up_and_sign_in_student"
        let!(:new_student2) { FactoryBot.create(:user, role: :student)}
        let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_student2.id) }
        let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_student2.id) }

      before do

        get '/api/v1/learning_sessions', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns empty array' do
        expect(response.body).to eq("[]")
      end

    end

    context 'with admin' do
      include_context "sign_up_and_sign_in_admin"
        let!(:new_student) { FactoryBot.create(:user, role: :student)}
        let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_student.id) }
        let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_student.id) }

      before do

        get '/api/v1/learning_sessions', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns everybodys learning_sessions' do
        expect(json[0]).to eq(JSON.parse(new_learning_session.to_json))
      end

    end

  end
end
