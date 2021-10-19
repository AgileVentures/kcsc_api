class CaseStudiesController < ApplicationController
  def index
    case_studies = Article.case_studies
    render json: case_studies, each_serializer: Article::IndexSerializer, root: 'case_studies'
  end
end
