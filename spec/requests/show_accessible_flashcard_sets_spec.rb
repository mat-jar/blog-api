require 'rails_helper'


RSpec.describe 'FlashcardSets', type: :request do
  describe 'GET /show_accessible' do

    context 'with teacher, their student and "class" flashcard_set' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :class) }

      before do

        get '/api/v1/flashcard_sets/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end

      it 'returns flashcard_set' do
        #expect(response.body).to eq(new_learning_session.to_json)
        expect(json[0]).to eq(JSON.parse(new_flashcard_set.to_json))


      end

    end

    context 'with teacher, their student and "personal" flashcard_set' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher.id) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :personal) }


      before do

        get '/api/v1/flashcard_sets/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end

      it 'returns empty array' do
        expect(response.body).to eq("[]")

      end

    end

    context 'with teacher, not their student and "class" flashcard_set' do
      include_context "sign_up_and_sign_in_teacher"

      let!(:new_teacher2) { FactoryBot.create(:user, role: :teacher)}
      let!(:new_student) { FactoryBot.create(:user, teacher_id: new_teacher2.id) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :class) }

      before do

        get '/api/v1/flashcard_sets/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns empty array' do
        expect(response.body).to eq("[]")
      end

    end

    context 'with student flashcard_sets all possible access (3 types)' do
      include_context "sign_up_and_sign_in_student"
      let!(:new_flashcard_set1) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :shared) }
      let!(:new_flashcard_set2) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :personal) }
      let!(:new_flashcard_set3) { FactoryBot.create(:flashcard_set, user_id: new_student.id, access: :class) }


      before do

        get '/api/v1/flashcard_sets/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns their flashcard set' do
        expect(json[0]).to eq(JSON.parse(new_flashcard_set1.to_json))
        expect(json[1]).to eq(JSON.parse(new_flashcard_set2.to_json))
        expect(json[2]).to eq(JSON.parse(new_flashcard_set3.to_json))
      end

    end

    context 'with student and "personal" flashcard_set of another student' do
      include_context "sign_up_and_sign_in_student"
      let!(:new_student2) { FactoryBot.create(:user, role: :student)}
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_student2.id, access: :personal) }


      before do

        get '/api/v1/flashcard_sets/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns empty array' do
        expect(response.body).to eq("[]")
      end

    end

    context 'with admin' do
      include_context "sign_up_and_sign_in_admin"
        let!(:new_student) { FactoryBot.create(:user, role: :student)}
        let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_student.id) }

      before do

        get '/api/v1/flashcard_sets/show_accessible', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
      it 'returns everybodys learning_sessions' do
        expect(json[0]).to eq(JSON.parse(new_flashcard_set.to_json))
      end

    end

  end
end
