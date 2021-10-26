class SectionsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update]

  def index
    view = View.find_by_name params[:view]
    sections = view.sections.sort_by { |section| section[:order] }

    render json: sections, each_serializer: Section::ShowSerializer
  end

  def create
    section = Section.create section_params
    render json: section, serializer: Section::ShowSerializer, status: :created
  end

  def update
    section = Section.find params[:id]
    update_relations(section)
    if section.update section_params
      render json: section, serializer: Section::ShowSerializer
    else
      render_error(section)
    end
  end

  private

  def render_error(section)
    render json: { message: section.errors.full_messages.to_sentence }, status: 422
  end

  def update_relations(section)
    if section.regular?
      ImageService.update(section, 'section', params[:section]) if params[:section][:image].present?
      ButtonsService.update(params[:section][:buttons]) if params[:section].has_key?(:buttons)
    end
  end

  def section_params
    params.require(:section).permit(:view_id, :header, :description)
  end
end
