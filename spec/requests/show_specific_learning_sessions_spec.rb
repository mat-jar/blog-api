require 'rails_helper'

RSpec.describe 'LearningSessions', type: :request do
  describe 'POST /show specific' do

    context 'with teacher, "class" flashcard_set_id and user_id who is this teachers student' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_flashcard_set1) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :class) }
      let!(:new_flashcard_set2) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :class) }
      let!(:new_learning_session1) { LearningSession.create(flashcard_set_id: new_flashcard_set1.id, user_id: new_student.id) }
      let!(:new_learning_session2) { LearningSession.create(flashcard_set_id: new_flashcard_set2.id, user_id: new_student.id) }

      before do

        post '/api/v1/learning_sessions/show_specific', params:
                          { learning_session: {
                            flashcard_set_id: new_flashcard_set1.id,
                            user_id: new_student.id
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns specific learning_sessions' do

        expect(json[0]).to eq(JSON.parse(new_learning_session1.to_json))
        expect(json[1]).to eq(nil)

      end

    end

    context 'with user, their flashcard_set_id and their user_id' do
      include_context "sign_up_and_sign_in_user"

      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_flashcard_set1) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
      let!(:new_flashcard_set2) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
      let!(:new_learning_session1) { LearningSession.create(flashcard_set_id: new_flashcard_set1.id, user_id: new_user.id) }
      let!(:new_learning_session2) { LearningSession.create(flashcard_set_id: new_flashcard_set2.id, user_id: new_user.id) }

      before do

        post '/api/v1/learning_sessions/show_specific', params:
                          { learning_session: {
                            flashcard_set_id: new_flashcard_set1.id,
                            user_id: new_user.id
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns specific learning_sessions' do

        expect(json[0]).to eq(JSON.parse(new_learning_session1.to_json))
        expect(json[1]).to eq(nil)

      end

    end

    context 'with teacher and not their student' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_teacher2) { FactoryBot.create(:user, role: :teacher)}
      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher2.id) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_student.id) }
      let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_student.id) }

      before do

        post '/api/v1/learning_sessions/show_specific', params:
                          { learning_session: {
                            flashcard_set_id: new_flashcard_set.id,
                            user_id: new_student.id
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

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

        post '/api/v1/learning_sessions/show_specific', params:
                          { learning_session: {
                            flashcard_set_id: new_flashcard_set.id,
                            user_id: new_student.id
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

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

        post '/api/v1/learning_sessions/show_specific', params:
                          { learning_session: {
                            flashcard_set_id: new_flashcard_set.id,
                            user_id: new_student.id
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns empty array' do
        expect(response.body).to eq("[]")
      end

    end

    context 'with admin' do
      include_context "sign_up_and_sign_in_admin"
        let!(:new_user) { FactoryBot.create(:user)}
        let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
        let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_user.id) }

      before do

        post '/api/v1/learning_sessions/show_specific', params:
                          { learning_session: {
                            flashcard_set_id: new_flashcard_set.id,
                            user_id: new_user.id
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end
      it 'returns everybodys learning_sessions' do
        expect(json[0]).to eq(JSON.parse(new_learning_session.to_json))
      end

    end

  end
end
