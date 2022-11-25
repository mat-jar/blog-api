require 'rails_helper'


RSpec.describe 'UserSentences', type: :request do
  describe 'POST /create' do


    context 'with valid parameters and user_sentence_set' do
    include_context "sign_up_and_sign_in_user"
    let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }
    let!(:new_user_sentence) { FactoryBot.build(:user_sentence) }

      before do
        post "/api/v1/user_sentence_sets/#{new_user_sentence_set.id}/user_sentences", params:
                          { user_sentence: {
                            sentence: new_user_sentence.sentence,
                            key_word: new_user_sentence.key_word,
                            hint: new_user_sentence.hint,
                            comment: new_user_sentence.comment
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns the sentence' do
        expect(json['sentence']).to eq(new_user_sentence.sentence)
      end

      it 'returns the key_word' do
        expect(json['key_word']).to eq(new_user_sentence.key_word)
      end

      it 'returns the hint' do
        expect(json['hint']).to eq(new_user_sentence.hint)
      end

      it 'returns the comment' do
        expect(json['comment']).to eq(new_user_sentence.comment)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end



    context 'with invalid parameters and user_sentence_set' do
      include_context "sign_up_and_sign_in_user"
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }
      before do
        post "/api/v1/user_sentence_sets/#{new_user_sentence_set.id}/user_sentences", params:
                          { user_sentence: {
                            sentence: '',
                            key_word: ''
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end
end
