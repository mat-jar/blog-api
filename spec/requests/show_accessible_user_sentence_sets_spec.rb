require 'rails_helper'


RSpec.describe 'UserSentenceSets', type: :request do
  describe 'POST /show_accessible' do

    context 'with teacher, their student and "class" user_sentence_set' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_student.id, access: :class) }

      before do

        post '/api/v1/user_sentence_sets/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end

      it 'returns user_sentence_set' do
        expect(json[0]).to eq(JSON.parse(new_user_sentence_set.to_json))


      end

    end

    context 'with teacher, their student and "personal" user_sentence_set' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_student.id, access: :personal) }


      before do

        post '/api/v1/user_sentence_sets/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end

      it 'returns empty array' do
        expect(response.body).to eq("[]")

      end

    end

    context 'with teacher, not their student and "class" user_sentence_set' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_teacher2) { FactoryBot.create(:user, role: :teacher)}
      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher2.id) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_student.id, access: :class) }

      before do

        post '/api/v1/user_sentence_sets/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns empty array' do
        expect(response.body).to eq("[]")
      end

    end

    context 'with student user_sentence_sets all possible access (3 types)' do
      include_context "sign_up_and_sign_in_student"
      let!(:new_user_sentence_set1) { FactoryBot.create(:user_sentence_set, user_id: new_student.id, access: :shared) }
      let!(:new_user_sentence_set2) { FactoryBot.create(:user_sentence_set, user_id: new_student.id, access: :personal) }
      let!(:new_user_sentence_set3) { FactoryBot.create(:user_sentence_set, user_id: new_student.id, access: :class) }


      before do

        post '/api/v1/user_sentence_sets/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns their user_sentence set' do
        expect(json).to include(JSON.parse(new_user_sentence_set1.to_json))
        expect(json).to include(JSON.parse(new_user_sentence_set2.to_json))
        expect(json).to include(JSON.parse(new_user_sentence_set3.to_json))
      end

    end

    context 'with student and "personal" user_sentence_set of another student' do
      include_context "sign_up_and_sign_in_student"
      let!(:new_student2) { FactoryBot.create(:user, role: :student)}
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_student2.id, access: :personal) }

      before do

        post '/api/v1/user_sentence_sets/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns empty array' do
        expect(response.body).to eq("[]")
      end

    end

    context 'with student and "class" user_sentence_set of their teacher' do
      include_context "sign_up_and_sign_in_student"
      let!(:new_teacher) { FactoryBot.create(:user, role: :teacher)}
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_teacher.id, access: :class) }

      before do
        new_student.update!(teacher_id: new_teacher.id)
        post '/api/v1/user_sentence_sets/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns user_sentence_set' do
        expect(json[0]).to eq(JSON.parse(new_user_sentence_set.to_json))

      end

    end

    context 'with student and "class" user_sentence_set of not their teacher' do
      include_context "sign_up_and_sign_in_student"
      let!(:new_teacher) { FactoryBot.create(:user, role: :teacher)}
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_teacher.id, access: :class) }

      before do
        post '/api/v1/user_sentence_sets/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns empty array' do
        expect(response.body).to eq("[]")
      end

    end

    context 'with admin' do
      include_context "sign_up_and_sign_in_admin"
        let!(:new_student) { FactoryBot.create(:user, role: :student)}
        let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_student.id) }

      before do

        post '/api/v1/user_sentence_sets/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns everybodys user_sentence_sets' do
        expect(json[0]).to eq(JSON.parse(new_user_sentence_set.to_json))
      end

    end

    context 'with teacher, their student, "class" user_sentence_set and correct "title" search params' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_student.id, access: :class) }

      before do

        post '/api/v1/user_sentence_sets/show_accessible', params:
                          { user_sentence_set: {
                            title: new_user_sentence_set.title
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns user_sentence_set' do
        expect(json[0]).to eq(JSON.parse(new_user_sentence_set.to_json))

      end
    end

    context 'with teacher, their student, "class" user_sentence_set and correct "user_id" search params' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_student.id, access: :class) }

      before do

        post '/api/v1/user_sentence_sets/show_accessible', params:
                          { user_sentence_set: {
                            user_id: new_user_sentence_set.user_id
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns user_sentence_set' do
        expect(json[0]).to eq(JSON.parse(new_user_sentence_set.to_json))

      end
    end

    context 'with teacher, their student, "class" user_sentence_set and correct "category" search params' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_student.id, access: :class) }

      before do

        post '/api/v1/user_sentence_sets/show_accessible', params:
                          { user_sentence_set: {
                            category: new_user_sentence_set.category
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns user_sentence_set' do
        expect(json[0]).to eq(JSON.parse(new_user_sentence_set.to_json))

      end
    end

    context 'with teacher, their student, "class" user_sentence_set and correct "description" search params' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_student.id, access: :class) }

      before do

        post '/api/v1/user_sentence_sets/show_accessible', params:
                          { user_sentence_set: {
                            description: new_user_sentence_set.description
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns user_sentence_set' do
        expect(json[0]).to eq(JSON.parse(new_user_sentence_set.to_json))

      end
    end

  end
end
