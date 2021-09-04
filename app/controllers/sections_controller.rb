class SectionsController < ApplicationController
  def index
    view = View.find_by_name params[:view]
    sections = view.sections

    render json: sections, each_serializer: Section::ShowSerializer
  end

  def update
    section = Section.find params[:id]
    section.update section_params

    render json: section, serializer: Section::ShowSerializer
  end

  def create
    section = Section.create section_params
    render json: section, serializer: Section::ShowSerializer, status: :created
  end

  def section_params
    params.require(:section).permit(:view_id, :header, :description)
  end
end