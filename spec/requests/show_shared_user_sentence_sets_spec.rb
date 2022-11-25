require 'rails_helper'


RSpec.describe 'UserSentenceSets', type: :request do
  describe 'POST /show_shared' do

    context 'with "shared" user_sentence_set' do

      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id, access: :shared) }

      before do

        post '/api/v1/user_sentence_sets/show_shared'
      end

      it 'returns user_sentence_set' do
        expect(json[0]).to eq(JSON.parse(new_user_sentence_set.to_json))

      end
    end

    context 'with "class" and "personal" user_sentence_sets' do

      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_user_sentence_set1) { FactoryBot.create(:user_sentence_set, user_id: new_user.id, access: :personal) }
      let!(:new_user_sentence_set2) { FactoryBot.create(:user_sentence_set, user_id: new_user.id, access: :class) }

      before do

        post '/api/v1/user_sentence_sets/show_shared'

      end

      it 'returns empty array' do
        expect(response.body).to eq("[]")

      end
    end

    context 'with "shared" user_sentence_set and correct "title" search params' do

      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id, access: :shared) }

      before do

        post '/api/v1/user_sentence_sets/show_shared', params:
                          { user_sentence_set: {
                            title: new_user_sentence_set.title
                          } }
      end

      it 'returns user_sentence_set' do
        expect(json[0]).to eq(JSON.parse(new_user_sentence_set.to_json))

      end
    end

    context 'with "shared" user_sentence_set and not correct "title" search params' do

      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id, access: :shared) }

      before do

        post '/api/v1/user_sentence_sets/show_shared', params:
                          { user_sentence_set: {
                            title: "koza"
                          } }
      end

      it 'returns empty array' do
        expect(response.body).to eq("[]")

      end
    end

  end
end
