require 'rails_helper'



describe 'Security APIs', type: :request do

  describe 'Get /securitiees' do
    let!(:my_article) {FactoryBot.create(:article)}
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
      @signed = current_user



      get '/api/v1/articles'
    end
      it 'will return securites' do
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)[0]['body']).to eq(my_article.body)

    end
    it 'will return securites3' do

    expect(my_article).to eq(my_article.body)

  end
  end
end
