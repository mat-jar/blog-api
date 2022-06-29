require 'rails_helper'


describe 'LearningSession', type: :request do

  describe 'GET /index' do
    let!(:admin_user) {FactoryBot.create(:user, role: 2)}
    let!(:teachers) {FactoryBot.create_list(:user, 3, role: 1)}
    let!(:students) {FactoryBot.create_list(:user, 10)}

    before do


      sign_in admin_user
      sign_in teachers[0]

      #get '/api/v1/articles'
    end
      it 'will return securites' do
      expect(admin_user.logged_in).to eq(true)
      #expect(response).to have_http_status(:success)
      #expect(JSON.parse(response.body)[0]['body']).to eq(my_article.body)
    end
  end
end
