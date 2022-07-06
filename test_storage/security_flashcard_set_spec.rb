require 'rails_helper'

describe 'Security APIs', type: :request do

  describe 'Get /securitiees' do
    let!(:my_article) {FactoryBot.create(:article)}
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
      @my_flashcard_set = FactoryBot.create(:flashcard_set, user_id: @user.id)

      get '/api/v1/flashcard_sets'
    end
      it 'will return securites' do
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)[0]['title']).to eq(@my_flashcard_set.title)
    end
  end
end
