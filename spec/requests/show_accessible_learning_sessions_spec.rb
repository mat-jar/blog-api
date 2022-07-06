require 'rails_helper'


RSpec.describe 'LearningSessions', type: :request do
  describe 'GET /show_accessible' do

    context 'with teacher, their student and "class" flashcard_set' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :class) }
      let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_student.id) }


      before do

        get '/api/v1/learning_sessions/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end

      it 'returns learning_session' do
        #expect(response.body).to eq(new_learning_session.to_json)
        expect(json[0]).to eq(JSON.parse(new_learning_session.to_json))


      end
    end

    context 'with teacher, their student and "personal" + "shared" flashcard_sets'  do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_flashcard_set1) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :personal) }
      let!(:new_flashcard_set2) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :shared) }
      let!(:new_learning_session1) { LearningSession.create(flashcard_set_id: new_flashcard_set1.id, user_id: new_student.id) }
      let!(:new_learning_session2) { LearningSession.create(flashcard_set_id: new_flashcard_set2.id, user_id: new_student.id) }


      before do

        get '/api/v1/learning_sessions/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end

      it 'returns empty array' do
        expect(response.body).to eq("[]")

      end
    end

    context 'with teacher and not their student' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_teacher2) { FactoryBot.create(:user, role: :teacher)}
      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher2.id) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :class) }
      let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_student.id) }

      before do

        get '/api/v1/learning_sessions/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns empty array' do
        expect(response.body).to eq("[]")
      end

    end

    context 'with student and their flashcard_set (personal/class/shared)' do
      include_context 'sign_up_and_sign_in_student'

      let!(:new_flashcard_set1) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :personal) }
      let!(:new_flashcard_set2) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :class) }
      let!(:new_flashcard_set3) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :shared) }
      let!(:new_learning_session1) { LearningSession.create(flashcard_set_id: new_flashcard_set1.id, user_id: new_student.id) }
      let!(:new_learning_session2) { LearningSession.create(flashcard_set_id: new_flashcard_set2.id, user_id: new_student.id) }
      let!(:new_learning_session3) { LearningSession.create(flashcard_set_id: new_flashcard_set3.id, user_id: new_student.id) }

      before do

        get '/api/v1/learning_sessions/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns their learning_sessions' do
        expect(json[0]).to eq(JSON.parse(new_learning_session1.to_json))
        expect(json[1]).to eq(JSON.parse(new_learning_session2.to_json))
        expect(json[2]).to eq(JSON.parse(new_learning_session3.to_json))
      end

    end

    context 'with student and learning_session of another student (personal/class/shared)' do
      include_context "sign_up_and_sign_in_student"
        let!(:new_student2) { FactoryBot.create(:user, role: :student)}
        let!(:new_flashcard_set1) { FactoryBot.create(:flashcard_set, user_id: new_student2.id, access: :personal) }
        let!(:new_flashcard_set2) { FactoryBot.create(:flashcard_set, user_id: new_student2.id, access: :class) }
        let!(:new_flashcard_set3) { FactoryBot.create(:flashcard_set, user_id: new_student2.id, access: :shared) }
        let!(:new_learning_session1) { LearningSession.create(flashcard_set_id: new_flashcard_set1.id, user_id: new_student2.id) }
        let!(:new_learning_session2) { LearningSession.create(flashcard_set_id: new_flashcard_set2.id, user_id: new_student2.id) }
        let!(:new_learning_session3) { LearningSession.create(flashcard_set_id: new_flashcard_set3.id, user_id: new_student2.id) }

      before do

        get '/api/v1/learning_sessions/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns empty array' do
        expect(response.body).to eq("[]")
      end

    end

    context 'with admin and users personal/class/shared flashcard_set' do
      include_context "sign_up_and_sign_in_admin"
        let!(:new_user) { FactoryBot.create(:user)}
        let!(:new_flashcard_set1) { FactoryBot.create(:flashcard_set, user_id: new_user.id, access: :personal) }
        let!(:new_flashcard_set2) { FactoryBot.create(:flashcard_set, user_id: new_user.id, access: :class) }
        let!(:new_flashcard_set3) { FactoryBot.create(:flashcard_set, user_id: new_user.id, access: :shared) }
        let!(:new_learning_session1) { LearningSession.create(flashcard_set_id: new_flashcard_set1.id, user_id: new_user.id) }
        let!(:new_learning_session2) { LearningSession.create(flashcard_set_id: new_flashcard_set2.id, user_id: new_user.id) }
        let!(:new_learning_session3) { LearningSession.create(flashcard_set_id: new_flashcard_set3.id, user_id: new_user.id) }

      before do

        get '/api/v1/learning_sessions/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns learning_sessions' do
        expect(json[0]).to eq(JSON.parse(new_learning_session1.to_json))
        expect(json[1]).to eq(JSON.parse(new_learning_session2.to_json))
        expect(json[2]).to eq(JSON.parse(new_learning_session3.to_json))
      end

    end

  end
end
