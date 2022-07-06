require 'rails_helper'

RSpec.describe 'FlashcardSets', type: :request do
  describe 'POST /create' do

    context 'with valid parameters' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_flashcard_set) { FactoryBot.build(:flashcard_set) }

      before do
        post '/api/v1/flashcard_sets', params:
                          { flashcard_set: {
                            title: new_flashcard_set.title,
                            description: new_flashcard_set.description,
                            category: new_flashcard_set.category
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns the title' do
        expect(json['title']).to eq(new_flashcard_set.title)
      end

      it 'returns the description' do
        expect(json['description']).to eq(new_flashcard_set.description)
      end

      it 'returns the category' do
        expect(json['category']).to eq(new_flashcard_set.category)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
    include_context "sign_up_and_sign_in_user"
      before do
        post '/api/v1/flashcard_sets', params:
                          { flashcard_set: {
                            title: '',
                            body: ''
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end
      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

      context 'without logged user' do

        let!(:new_flashcard_set) { FactoryBot.build(:flashcard_set) }

        before do
          post '/api/v1/flashcard_sets', params:
                            { flashcard_set: {
                              title: new_flashcard_set.title,
                              description: new_flashcard_set.description,
                              category: new_flashcard_set.category
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
