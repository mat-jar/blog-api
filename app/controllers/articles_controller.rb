class ArticlesController < ApplicationController
  def index
    articles = Article.order("created_at DESC")
    render json: articles
  end

  def create
    article = Article.create(article_param)
    render json: article
  end

  def update
    article = Article.find(params[:id])
    article.update(article_param)
    render json: article
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    head :no_content, status: :ok
  end

  private
    def article_param
      params.require(:article).permit(:title, :body)
    end
end
