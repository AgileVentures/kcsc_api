class ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: articles, each_serializer: Article::IndexSerializer
  end

  def show
    article = Article.find(params[:id])
    render json: article, serializer: Article::ShowSerializer
  end
end
