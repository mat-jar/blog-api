require 'rails_helper'


RSpec.describe 'FlashcardSets', type: :request do
  describe 'POST /show_shared' do

    context 'with "shared" flashcard_set' do

      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id, access: :shared) }

      before do

        post '/api/v1/flashcard_sets/show_shared'
      end

      it 'returns flashcard_set' do
        expect(json[0]).to eq(JSON.parse(new_flashcard_set.to_json))

      end
    end

    context 'with "class" and "personal" flashcard_sets' do

      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_flashcard_set1) { FactoryBot.create(:flashcard_set, user_id: new_user.id, access: :personal) }
      let!(:new_flashcard_set2) { FactoryBot.create(:flashcard_set, user_id: new_user.id, access: :class) }

      before do

        post '/api/v1/flashcard_sets/show_shared'

      end

      it 'returns empty array' do
        expect(response.body).to eq("[]")

      end
    end

    context 'with "shared" flashcard_set and correct "title" search params' do

      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id, access: :shared) }

      before do

        post '/api/v1/flashcard_sets/show_shared', params:
                          { flashcard_set: {
                            title: new_flashcard_set.title
                          } }
      end

      it 'returns flashcard_set' do
        expect(json[0]).to eq(JSON.parse(new_flashcard_set.to_json))

      end
    end

    context 'with "shared" flashcard_set and not correct "title" search params' do

      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id, access: :shared) }

      before do

        post '/api/v1/flashcard_sets/show_shared', params:
                          { flashcard_set: {
                            title: "koza"
                          } }
      end

      it 'returns empty array' do
        expect(response.body).to eq("[]")

      end
    end

  end
end
