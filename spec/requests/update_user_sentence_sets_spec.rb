require 'rails_helper'

RSpec.describe 'UserSentenceSets', type: :request do
  describe 'PUT /update' do

    context 'with valid parameters' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }

      before do
        put "/api/v1/user_sentence_sets/#{new_user_sentence_set.id}", params:
                          { user_sentence_set: {
                            title: "Updated title",
                            description: "Updated description",
                            category: "Updated category"
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns the title' do
        expect(json['title']).to eq("Updated title")
      end

      it 'returns the description' do
        expect(json['description']).to eq("Updated description")
      end

      it 'returns the category' do
        expect(json['category']).to eq("Updated category")
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }

      before do
        put "/api/v1/user_sentence_sets/#{new_user_sentence_set.id}", params:
                          { user_sentence_set: {
                            title: "",
                            description: "",
                            category: ""
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

      context 'without logged user' do
        let!(:new_user) { FactoryBot.create(:user) }
        let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }

          before do
            put "/api/v1/user_sentence_sets/#{new_user_sentence_set.id}", params:
                              { user_sentence_set: {
                                title: "Updated title",
                                description: "Updated description",
                                category: "Updated category"
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
