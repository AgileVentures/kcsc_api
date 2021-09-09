class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[create update ]

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
    if article.persisted? && attach_image(article)
      render json: article, serializer: Article::ShowSerializer, status: 201
    else
      render_error(article)
    end
  end

  def update
    article = Article.find(params[:id])
    update_image(article) if params[:article][:image].present?
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

  def attach_image(article)
    params[:article][:image].present? && DecodeService.attach_image(params[:article][:image], Image.create(article: article, alt_text: params[:article][:alt]))
  end

  def update_image(article)
    DecodeService.attach_image(params[:article][:image], article.image) unless params[:article][:image].include? 'http'
    article.image.update(alt_text: params[:article][:alt])
  end
end
