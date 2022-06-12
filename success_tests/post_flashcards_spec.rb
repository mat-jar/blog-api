require 'rails_helper'
require "support/sign_up_users.rb"
require "support/sign_in_users.rb"
require "support/create_flashcard_sets.rb"

RSpec.describe 'Flashcards', type: :request do
  describe 'POST /create' do


    context 'with valid parameters and flashcard_set' do
    include_context "sign_up_users"
    include_context "sign_in_users"
    include_context "create_flashcard_sets"


      let!(:my_flashcard) { FactoryBot.build(:flashcard) }

      before do
        post "/api/v1/flashcard_sets/#{my_flashcard_set.id}/flashcards", params:
                          { flashcard: {
                            front_text: my_flashcard.front_text,
                            back_text: my_flashcard.back_text
                          } }
      end

      it 'returns the front_text' do
        expect(json['front_text']).to eq(my_flashcard.front_text)
      end

      it 'returns the back_text' do
        expect(json['back_text']).to eq(my_flashcard.back_text)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end

    

    context 'with invalid parameters and flashcard_set' do
    include_context "sign_up_users"
    include_context "sign_in_users"
    include_context "create_flashcard_sets"
      before do
        post "/api/v1/flashcard_sets/#{my_flashcard_set.id}/flashcards", params:
                          { flashcard: {
                            front_text: '',
                            back_text: ''
                          } }
      end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end
end
