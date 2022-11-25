require 'rails_helper'

RSpec.describe 'LearningSessions', type: :request do
  describe 'POST /show specific' do

    context 'with teacher, "class" flashcard_set_id and user_id who is this teachers student' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_flashcard_set1) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :class) }
      let!(:new_flashcard_set2) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :class) }
      let!(:new_learning_session1) { new_flashcard_set1.learning_sessions.create(user_id: new_student.id) }
      let!(:new_learning_session2) { new_flashcard_set2.learning_sessions.create(user_id: new_student.id) }

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

    context 'with teacher and "class" flashcard_set_id made by student' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student1) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_student2) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_student1.id, access: :class) }
      let!(:new_learning_session1) { new_flashcard_set.learning_sessions.create(user_id: new_student1.id) }
      let!(:new_learning_session2) { new_flashcard_set.learning_sessions.create(user_id: new_student2.id) }

      before do

        post '/api/v1/learning_sessions/show_specific', params:
                          { learning_session: {
                            flashcard_set_id: new_flashcard_set.id
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns learning_sessions of all students learning this flashcard_set' do

        expect(json).to include(JSON.parse(new_learning_session1.to_json))
        expect(json).to include(JSON.parse(new_learning_session2.to_json))

      end

    end

    context 'with teacher and "class" flashcard_set_id made by teacher' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student1) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_student2) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_teacher.id, access: :class) }
      let!(:new_learning_session1) { new_flashcard_set.learning_sessions.create(user_id: new_student1.id) }
      let!(:new_learning_session2) { new_flashcard_set.learning_sessions.create(user_id: new_student2.id) }

      before do

        post '/api/v1/learning_sessions/show_specific', params:
                          { learning_session: {
                            flashcard_set_id: new_flashcard_set.id
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns learning_sessions of all students learning this flashcard_set' do

        expect(json).to include(JSON.parse(new_learning_session1.to_json))
        expect(json).to include(JSON.parse(new_learning_session2.to_json))

      end

    end

    context 'with teacher their student user_id' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_flashcard_set1) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :class) }
      let!(:new_flashcard_set2) { FactoryBot.create(:flashcard_set, user_id: new_teacher.id, access: :class) }
      let!(:new_flashcard_set3) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :shared) }
      let!(:new_flashcard_set4) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :personal) }
      let!(:new_learning_session1) { new_flashcard_set1.learning_sessions.create(user_id: new_student.id) }
      let!(:new_learning_session2) { new_flashcard_set2.learning_sessions.create(user_id: new_student.id) }
      let!(:new_learning_session3) { new_flashcard_set3.learning_sessions.create(user_id: new_student.id) }
      let!(:new_learning_session4) { new_flashcard_set4.learning_sessions.create(user_id: new_student.id) }

      before do

        post '/api/v1/learning_sessions/show_specific', params:
                          { learning_session: {
                            user_id: new_student.id
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns learning_sessions of all "class" flashcard_sets learnt' do

        expect(json).to include(JSON.parse(new_learning_session1.to_json))
        expect(json).to include(JSON.parse(new_learning_session2.to_json))
        expect(json[2]).to eq(nil)

      end

    end

    context 'with teacher and empty params' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_flashcard_set1) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :class) }
      let!(:new_flashcard_set2) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :class) }
      let!(:new_learning_session1) { new_flashcard_set1.learning_sessions.create(user_id: new_student.id) }
      let!(:new_learning_session2) { new_flashcard_set2.learning_sessions.create(user_id: new_student.id) }

      before do

        post '/api/v1/learning_sessions/show_specific', params:
                          { learning_session: {
                            flashcard_set_id: "",
                            user_id: ""
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it 'returns the message' do
        expect(json['message']).to eq("Provide at least one valid parameter")
      end

    end

    context 'with teacher and no params' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_flashcard_set1) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :class) }
      let!(:new_flashcard_set2) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :class) }
      let!(:new_learning_session1) { new_flashcard_set1.learning_sessions.create(user_id: new_student.id) }
      let!(:new_learning_session2) { new_flashcard_set2.learning_sessions.create(user_id: new_student.id) }

      before do

        post '/api/v1/learning_sessions/show_specific', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it 'returns the message' do
        expect(json['message']).to eq("Provide at least one valid parameter")
      end

    end

    context 'with user, their flashcard_set_id and their user_id' do
      include_context "sign_up_and_sign_in_user"

      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_flashcard_set1) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
      let!(:new_flashcard_set2) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
      let!(:new_learning_session1) { new_flashcard_set1.learning_sessions.create(user_id: new_user.id) }
      let!(:new_learning_session2) { new_flashcard_set2.learning_sessions.create(user_id: new_user.id) }

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
      let!(:new_learning_session) { new_flashcard_set.learning_sessions.create(user_id: new_student.id) }


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
        let!(:new_learning_session) { new_flashcard_set.learning_sessions.create(user_id: new_student.id) }

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
        let!(:new_learning_session) { new_flashcard_set.learning_sessions.create(user_id: new_student2.id) }

      before do

        post '/api/v1/learning_sessions/show_specific', params:
                          { learning_session: {
                            flashcard_set_id: new_flashcard_set.id,
                            user_id: new_student2.id
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
        let!(:new_learning_session) { new_flashcard_set.learning_sessions.create(user_id: new_user.id) }

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
