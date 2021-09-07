class InformationController < ApplicationController
  before_action :authenticate_user!, only: %i[create update]

  def index
    information_items = InformationItem.all
    information_items = information_items.select { |item| item.publish == true } unless current_user
    information_items = information_items.sort_by { |item| item[:id] }
    render json: { information_items: information_items }
  end

  def create
    information_item = InformationItem.create(information_item_params)
    if information_item.persisted?
      render json: information_item, serializer: InformationItem::ShowSerializer, status: 201
    else
      render_error(information_item)
    end
  end

  def update
    information_item = InformationItem.find(params[:id])

    params['information_item'].each do |key, value|
      @updated = information_item.update(Hash[key, value]) if information_item.attributes.key?(key)
      break if @updated == false
    end

    if @updated
      render json: information_item, serializer: InformationItem::ShowSerializer
    else
      render_error(information_item)
    end
  end

  private

  def render_error(information_item)
    render json: { message: information_item.errors.full_messages.to_sentence }, status: 422
  end

  def information_item_params
    params.require(:information_item).permit(:header, :description, :link, :pinned, :publish)
  end
end
