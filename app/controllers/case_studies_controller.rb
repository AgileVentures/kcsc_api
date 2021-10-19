class CaseStudiesController < ApplicationController
  def index
    case_studies = Article.case_studies
    render json: case_studies, each_serializer: CaseStudy::IndexSerializer
  end


end
