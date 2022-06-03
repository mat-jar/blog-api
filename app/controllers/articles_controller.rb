class ArticlesController < ApplicationController
  before_action :authenticate_user!
  def index
    #articles = Article.order("created_at DESC")
    articles = Article.all
    render json: articles
  end

  def create
    article = Article.create(article_param)

    if article.save
      render json: article, status: :ok
    else
      render json: article.errors, status: :unprocessable_entity
    end

  end

  def update
    article = Article.find(params[:id])
    article.update(article_param)
    render json: article, status: :ok
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
