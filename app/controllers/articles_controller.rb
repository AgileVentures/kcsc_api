class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]

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
      render_error(article)
    end
  end

  def update
    article = Article.find(params[:id])
    if article.update(article_params)
      render json: article, serializer: Article::ShowSerializer
    else
      render_error(article)
    end
  end

  private

  def render_error(article)
    render json: { message: article.errors.full_messages.to_sentence }, status: 422

  end

  def article_params
    params.require(:article).permit(:title, :body, :published)
  end
end
