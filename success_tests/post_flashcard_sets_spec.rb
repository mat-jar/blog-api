require 'rails_helper'
require "support/sign_up_users.rb"
require "support/sign_in_users.rb"

RSpec.describe 'FlashcardSets', type: :request do
  describe 'POST /create' do

    context 'with valid parameters' do
    include_context "sign_up_users"
    include_context "sign_in_users"
      let!(:my_flashcard_set) { FactoryBot.build(:flashcard_set) }

      before do
        post '/api/v1/flashcard_sets', params:
                          { flashcard_set: {
                            title: my_flashcard_set.title,
                            description: my_flashcard_set.description,
                            category: my_flashcard_set.category
                          } }
      end

      it 'returns the title' do
        expect(json['title']).to eq(my_flashcard_set.title)
      end

      it 'returns the description' do
        expect(json['description']).to eq(my_flashcard_set.description)
      end

      it 'returns the category' do
        expect(json['category']).to eq(my_flashcard_set.category)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
    include_context "sign_up_users"
    include_context "sign_in_users"
      before do
        post '/api/v1/flashcard_sets', params:
                          { flashcard_set: {
                            title: '',
                            body: ''
                          } }
      end
      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

      context 'without logged user' do

        let!(:my_flashcard_set) { FactoryBot.build(:flashcard_set) }

        before do
          post '/api/v1/flashcard_sets', params:
                            { flashcard_set: {
                              title: my_flashcard_set.title,
                              description: my_flashcard_set.description,
                              category: my_flashcard_set.category
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
