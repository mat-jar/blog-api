require 'rails_helper'


RSpec.describe 'Flashcards', type: :request do
  describe 'PUT /update' do


    context 'with valid parameters and flashcard_set' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
    let!(:new_flashcard) { FactoryBot.create(:flashcard, flashcard_set_id: new_flashcard_set.id) }

      before do
        put "/api/v1/flashcards/#{new_flashcard.id}", params:
                          { flashcard: {
                            front_text:  "Updated front text",
                            back_text: "Updated back text"
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns the front_text' do
        expect(json['front_text']).to eq("Updated front text")
      end

      it 'returns the back_text' do
        expect(json['back_text']).to eq("Updated back text")
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end



    context 'with invalid parameters and flashcard_set' do
      include_context "sign_up_and_sign_in_user"
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
      let!(:new_flashcard) { FactoryBot.create(:flashcard, flashcard_set_id: new_flashcard_set.id) }

        before do
          put "/api/v1/flashcards/#{new_flashcard.id}", params:
                            { flashcard: {
                              front_text:  "",
                              back_text: ""
                            } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
        end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'without logged user' do
      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
      let!(:new_flashcard) { FactoryBot.create(:flashcard, flashcard_set_id: new_flashcard_set.id) }

      before do
        put "/api/v1/flashcards/#{new_flashcard.id}", params:
                          { flashcard: {
                            front_text:  "Updated front text",
                            back_text: "Updated back text"
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
