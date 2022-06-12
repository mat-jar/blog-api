require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /create' do
    include_context "sign_up_users"

      it 'returns the message' do
        expect(json['message']).to eq("Signed up.")
      end


      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/users', params:
                          { user: {
                            email: '',
                            password: ''
                          } }
      end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end
