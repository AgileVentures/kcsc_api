class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def index
    articles = Article.all
    render json: articles, each_serializer: Article::IndexSerializer
  end

  def show
    article = Article.find(params[:id])
    render json: article, serializer: Article::ShowSerializer
  end

  def create
    article = Article.create(article_params.merge!(author: current_user))
    if article.persisted?
      render json: article, serializer: Article::ShowSerializer, status: 201
    else
      render json: article.errors.full_messages.to_sentence, status: 422
    end
  end

  def update
    article = Article.find(params[:id])
    if article.update(article_params)
      render json: article, serializer: Article::ShowSerializer
    else
      render json: article.errors.full_messages.to_sentence, status: 422
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
