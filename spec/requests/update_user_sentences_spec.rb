require 'rails_helper'


RSpec.describe 'UserSentences', type: :request do
  describe 'PUT /update' do


    context 'with valid parameters and user_sentence_set' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }
    let!(:new_user_sentence) { FactoryBot.create(:user_sentence, user_sentence_set_id: new_user_sentence_set.id) }

      before do
        put "/api/v1/user_sentences/#{new_user_sentence.id}", params:
                          { user_sentence: {
                            sentence:  "Updated sentence",
                            key_word: "Updated key word",
                            hint: "Updated hint",
                            comment: "Updated comment"
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns the sentence' do
        expect(json['sentence']).to eq("Updated sentence")
      end

      it 'returns the key_word' do
        expect(json['key_word']).to eq("Updated key word")
      end

      it 'returns the hint' do
        expect(json['hint']).to eq("Updated hint")
      end

      it 'returns the comment' do
        expect(json['comment']).to eq("Updated comment")
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end



    context 'with invalid parameters and user_sentence_set' do
      include_context "sign_up_and_sign_in_user"
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }
      let!(:new_user_sentence) { FactoryBot.create(:user_sentence, user_sentence_set_id: new_user_sentence_set.id) }

        before do
          put "/api/v1/user_sentences/#{new_user_sentence.id}", params:
                            { user_sentence: {
                              sentence:  "",
                              key_word: "",
                              hint: "",
                              comment: ""
                            } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
        end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'without logged user' do
      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }
      let!(:new_user_sentence) { FactoryBot.create(:user_sentence, user_sentence_set_id: new_user_sentence_set.id) }

      before do
        put "/api/v1/user_sentences/#{new_user_sentence.id}", params:
                          { user_sentence: {
                            sentence:  "Updated sentence",
                            key_word: "Updated key word",
                            hint: "Updated hint",
                            comment: "Updated comment"
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
