require 'rails_helper'


RSpec.describe 'UserDetails', type: :request do
  describe 'POST /show_all' do

    context 'with admin' do
      include_context "sign_up_and_sign_in_admin"

      let!(:new_user1) { FactoryBot.create(:user) }
      let!(:new_user2) { FactoryBot.create(:user) }

      before do

        get '/api/v1/users/user_details/show_all', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end

      it 'returns all users' do
        expect(json).to include(JSON.parse(new_user1.to_json))
        expect(json).to include(JSON.parse(new_user2.to_json))
        expect(json).to include(JSON.parse(User.find(new_admin.id).to_json))

      end
    end

    context 'with user' do
      include_context "sign_up_and_sign_in_user"

      let!(:new_user1) { FactoryBot.create(:user) }
      let!(:new_user2) { FactoryBot.create(:user) }

      before do

        get '/api/v1/users/user_details/show_all', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end

      it 'returns a forbidden status' do
        expect(response).to have_http_status(:forbidden)
      end
    end

  end
end
