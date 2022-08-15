require 'rails_helper'


RSpec.describe 'UserDetails', type: :request do
  describe 'POST /show' do

    context 'without user_id in params' do
      include_context "sign_up_and_sign_in_user"

      before do

        post '/api/v1/users/user_details/show', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end

      it 'returns current_user' do
        expect(json).to eq(JSON.parse(User.find(new_user.id).to_json))

      end
    end

    context 'with user and id of another user' do
      include_context "sign_up_and_sign_in_user"

      let!(:new_user2) { FactoryBot.create(:user) }

      before do

        post '/api/v1/users/user_details/show', params:
                          { user: {
                            user_id: new_user2.id
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end
    
      it 'returns the message' do
        expect(json['message']).to eq("Not authorized")
      end

      it 'returns status forbidden - code 403' do
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with admin and id of another user' do
      include_context "sign_up_and_sign_in_admin"

      let!(:new_user) { FactoryBot.create(:user) }



      before do

        post '/api/v1/users/user_details/show', params:
                          { user: {
                            user_id: new_user.id
                          } }, headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}

      end

      it 'returns user details' do
        expect(json).to eq(JSON.parse(User.find(new_user.id).to_json))

      end
    end

  end
end
