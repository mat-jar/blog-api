require "rails_helper"

RSpec.describe Api::V1::UserSentenceSetsController, type: :controller do
  describe 'GET#show' do
    context 'given a slug to an existing course' do
      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }
      it 'renders the show view' do
        slug = "#{new_user_sentence_set.id}-#{new_user_sentence_set.title.parameterize}"

        sign_in new_user
        get :show, params: { id: slug }


        expect(response).to have_http_status :ok
        expect(response.body).to eq(new_user_sentence_set.to_json)
      end
    end

    context 'given an id to an existing course' do
      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }
      it 'renders the show view' do

        sign_in new_user
        get :show, params: { id: new_user_sentence_set.id }


        expect(response).to have_http_status :ok
        expect(response.body).to eq(new_user_sentence_set.to_json)
      end
    end

    context 'given a slug with a wrong title' do
      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }
      it 'responds with not found status' do
        slug = "#{new_user_sentence_set.id}-foo-bar"


        sign_in new_user
        get :show, params: { id: slug }

        expect(response).to have_http_status :not_found
      end
    end

    context 'given a wrong slug with a wrong id' do
      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }
      it 'responds with not found status' do
        slug = "#{new_user_sentence_set.id+1}-#{new_user_sentence_set.title.parameterize}"


        sign_in new_user
        get :show, params: { id: slug }

        expect(response).to have_http_status :not_found
      end
    end
  end
end
