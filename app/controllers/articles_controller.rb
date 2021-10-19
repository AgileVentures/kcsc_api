class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[create update]

  def index
    articles = Article.all
    articles = articles.select { |article| article.published == true } unless current_user
    articles = articles.sort_by{ |article| article[:updated_at] }.reverse
    render json: articles, each_serializer: Article::IndexSerializer
  end

  def show
    article = Article.unscoped.find(params[:id])
    render json: article, serializer: Article::ShowSerializer
  end

  def create
    article = Article.create(article_params.merge!(author: current_user))
    if article.persisted? && ImageService.attach(article, 'article', params[:article])
      render json: article, serializer: Article::ShowSerializer, status: 201
    else
      render_error(article)
    end
  end

  def update
    article = Article.unscoped.find(params[:id])
    ImageService.update(article, 'article', params[:article]) if params[:article][:image].present?
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
    params.require(:article).permit(:title, :body, :published, :case_study)
  end
end
