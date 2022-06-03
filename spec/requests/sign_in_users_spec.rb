require 'rails_helper'
require "support/sign_up_users.rb"
require "support/sign_in_users.rb"

RSpec.describe 'Users', type: :request do
  describe 'POST /create' do
    include_context "sign_up_users"
    include_context "sign_in_users"

      it 'returns the message' do
        expect(json['message']).to eq("Logged.")
      end

      it 'returns logged_in == true' do
        expect(json['logged_in']).to eq(true)
      end


      it 'returns a created status' do
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
