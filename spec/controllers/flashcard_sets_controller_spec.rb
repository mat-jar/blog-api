require "rails_helper"

RSpec.describe Api::V1::FlashcardSetsController, type: :controller do
  describe 'GET#show' do
    context 'given a slug to an existing set' do
      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
      it 'renders the show method' do
        slug = "#{new_flashcard_set.id}-#{new_flashcard_set.title.parameterize}"

        sign_in new_user
        get :show, params: { id: slug }


        expect(response).to have_http_status :ok
        expect(response.body).to eq(new_flashcard_set.to_json)
      end
    end

    context 'given an id to an existing course' do
      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
      it 'renders the show view' do

        sign_in new_user
        get :show, params: { id: new_flashcard_set.id }


        expect(response).to have_http_status :ok
        expect(response.body).to eq(new_flashcard_set.to_json)
      end
    end

    context 'given a slug with a wrong title' do
      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
      it 'responds with not found status' do
        slug = "#{new_flashcard_set.id}-foo-bar"


        sign_in new_user
        get :show, params: { id: slug }

        expect(response).to have_http_status :not_found
      end
    end

    context 'given a wrong slug with a wrong id' do
      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
      it 'responds with not found status' do
        slug = "#{new_flashcard_set.id+1}-#{new_flashcard_set.title.parameterize}"


        sign_in new_user
        get :show, params: { id: slug }

        expect(response).to have_http_status :not_found
      end
    end
  end
end
