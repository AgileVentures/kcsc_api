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

  def section_params
    params.require(:section).permit(:name, :view_id, :header)
  end
end
