require 'rails_helper'


RSpec.describe 'Users', type: :request do
  describe 'DELETE /sign_out' do

    context 'with token' do
      include_context "sign_up_user"
      include_context "sign_in_user"
      before do
        delete '/api/v1/users/sign_out', headers: { Authorization:  "Bearer " + request.env["warden-jwt_auth.token"]}
      end

      it 'returns the message' do
        expect(json['message']).to eq("Logged out.")
      end


      it 'returns a logged status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'without token' do
      include_context "sign_up_user"
      include_context "sign_in_user"
      before do
        delete '/api/v1/users/sign_out'
      end

      it 'returns the message' do
        expect(json['message']).to eq("Logged out failure.")
      end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unauthorized)
      end

    end
  end
end
