require 'rails_helper'


RSpec.describe 'Users', type: :request do
  describe 'POST /create' do

    context 'with valid parameters' do
      let!(:new_user) { FactoryBot.build(:user)}

      before do
        post '/api/v1/users', params:
                          { user: {
                            email: new_user.email,
                            password: new_user.password
                          } }
        post '/api/v1/users/sign_in', params:
                          { user: {
                            email: new_user.email,
                            password: new_user.password
                          } }
              end

      it 'returns the message' do
        expect(json['message']).to eq("Logged.")
      end


      it 'returns a logged status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/users/sign_in', params:
                          { user: {
                            email: '',
                            password: ''
                          } }
      end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unauthorized)
      end

    end
  end
end
