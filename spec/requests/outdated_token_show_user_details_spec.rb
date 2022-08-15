require 'rails_helper'


RSpec.describe 'UserDetails', type: :request do
  describe 'POST /show' do

    context 'without user_id in params and outdated token' do
      include_context "sign_up_and_sign_in_user"

      before do
        token = request.env["warden-jwt_auth.token"]
        sleep 1
        post '/api/v1/users/sign_in', params:
                          { user: {
                            email: new_user.email,
                            password: new_user.password
                          } }


        post '/api/v1/users/user_details/show', headers: { Authorization:  "Bearer " + token }

      end

      it 'returns outdated token message' do
        expect(response.body).to eq("Outdated token")

      end
    end

  end
end
