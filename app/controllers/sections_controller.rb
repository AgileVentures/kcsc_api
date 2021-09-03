class SectionsController < ApplicationController
  def show
    view = View.find_by_name params[:view]
    sections = view.sections

    render json: sections, each_serializer: Sections::ShowSerializer
  end
end
