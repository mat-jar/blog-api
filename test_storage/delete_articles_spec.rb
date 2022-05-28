require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe "DELETE /destroy" do
    let!(:article) { FactoryBot.create(:article) }

    before do
      delete "/api/v1/articles/#{article.id}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
