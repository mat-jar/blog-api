require 'rails_helper'

RSpec.describe 'UserDetails', type: :request do
  describe 'PUT /update' do

    context 'with valid parameters for student with teacher' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_teacher) { FactoryBot.create(:user, role: :teacher) }


      before do
        put "/api/v1/users/user_details", params:
                          { user: {
                            name: "Updated name",
                            teacher_id: new_teacher.id,
                            role: "student"
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns the name' do
        expect(json['name']).to eq("Updated name")
      end

      it 'returns the teacher_id' do
        expect(json['teacher_id']).to eq(new_teacher.id)
      end

      it 'returns the role' do
        expect(json['role']).to eq("student")
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with valid parameters for teacher' do
    include_context "sign_up_and_sign_in_user"


      before do
        put "/api/v1/users/user_details", params:
                          { user: {
                            name: "Updated name",
                            role: "teacher"
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns the name' do
        expect(json['name']).to eq("Updated name")
      end


      it 'returns the role' do
        expect(json['role']).to eq("teacher")
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end





    context 'with invalid teacher_id' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_teacher) { FactoryBot.create(:user, role: :teacher) }

      before do
        put "/api/v1/users/user_details", params:
                              { user: {
                                teacher_id: new_teacher.id + 1
                              } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns a not found status' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with invalid role' do
    include_context "sign_up_and_sign_in_user"

      before do
        put "/api/v1/users/user_details", params:
                              { user: {
                                role: "tutor"
                              } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns an unprocessable_entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with invalid parameters for student with student as a teacher' do
    include_context "sign_up_and_sign_in_student"
    let!(:new_student2) { FactoryBot.create(:user, role: :student) }

      before do
        put "/api/v1/users/user_details", params:
                          { user: {
                            teacher_id: new_student2.id
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns an unprocessable_entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with invalid parameters for teacher with a teacher' do
    include_context "sign_up_and_sign_in_teacher"
    let!(:new_teacher2) { FactoryBot.create(:user, role: :teacher) }



      before do
        put "/api/v1/users/user_details", params:
                          { user: {
                            teacher_id: new_teacher2.id
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns an unprocessable_entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end


context 'with invalid parameters for teacher with student as a teacher' do
    include_context "sign_up_and_sign_in_teacher"
    let!(:new_student) { FactoryBot.create(:user, role: :student) }



      before do
        put "/api/v1/users/user_details", params:
                          { user: {
                            teacher_id: new_student.id
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns an unprocessable_entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

      context 'without logged user' do
        let!(:new_user) { FactoryBot.create(:user) }
        let!(:new_teacher) { FactoryBot.create(:user, role: :teacher) }

          before do
            put "/api/v1/users/user_details", params:
                              { user: {
                                name: "Updated name",
                                teacher_id: new_teacher.id,
                                role: "student"
                              } }
          end
        it 'returns a demand to log in or sign up' do
          expect(response.body).to eq("You need to log in or sign up before continuing.")
        end
        it 'returns an unauthorized status' do
          expect(response).to have_http_status(:unauthorized)
        end
    end

    context 'with user and another user' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_user2) { FactoryBot.create(:user) }
    let!(:new_teacher) { FactoryBot.create(:user, role: :teacher) }


      before do
        put "/api/v1/users/user_details", params:
                          { user: {
                            user_id: new_user2.id,
                            name: "Updated name",
                            teacher_id: new_teacher.id,
                            role: "student"
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end


      it 'returns a forbidden status' do
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with admin and a user' do
    include_context "sign_up_and_sign_in_admin"
    let!(:new_user) { FactoryBot.create(:user) }
    let!(:new_teacher) { FactoryBot.create(:user, role: :teacher) }


      before do
        put "/api/v1/users/user_details", params:
                          { user: {
                            user_id: new_user.id,
                            name: "Updated name",
                            teacher_id: new_teacher.id,
                            role: "student"
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with admin and a user and invalid role' do
    include_context "sign_up_and_sign_in_admin"
    let!(:new_user) { FactoryBot.create(:user) }
    let!(:new_teacher) { FactoryBot.create(:user, role: :teacher) }


      before do
        put "/api/v1/users/user_details", params:
                          { user: {
                            user_id: new_user.id,
                            name: "",
                            teacher_id: "",
                            role: "tutor"
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns an unprocessable_entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with admin and a user and invalid teacher_id' do
    include_context "sign_up_and_sign_in_admin"
    let!(:new_user) { FactoryBot.create(:user) }
    let!(:new_teacher) { FactoryBot.create(:user, role: :teacher) }


      before do
        put "/api/v1/users/user_details", params:
                          { user: {
                            user_id: new_user.id,
                            name: "",
                            teacher_id: new_teacher.id + 1,
                            role: "student"
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns a not_found status' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with admin and a user for student as a teacher' do
    include_context "sign_up_and_sign_in_admin"
    let!(:new_student1) { FactoryBot.create(:user, role: :student) }
    let!(:new_student2) { FactoryBot.create(:user, role: :student) }


      before do
        put "/api/v1/users/user_details", params:
                          { user: {
                            user_id: new_student1.id,
                            teacher_id: new_student2.id,
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns an unprocessable_entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end
end
