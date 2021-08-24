class ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: { articles: articles }
  end

  def show; end
end
