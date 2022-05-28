require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'POST /create' do
    context 'with valid parameters' do
      let!(:my_article) { FactoryBot.create(:article) }

      before do
        post '/api/v1/articles', params:
                          { article: {
                            title: my_article.title,
                            body: my_article.body
                          } }
      end

      it 'returns the title' do
        expect(json['title']).to eq(my_article.title)
      end

      it 'returns the body' do
        expect(json['body']).to eq(my_article.body)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/articles', params:
                          { article: {
                            title: '',
                            body: ''
                          } }
      end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end
end
