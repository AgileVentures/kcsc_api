class InformationController < ApplicationController
  def index
    information_items = InformationItem.all
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

  private

  def render_error(information_item)
    render json: { message: information_item.errors.full_messages.to_sentence }, status: 422
  end

  def information_item_params
    params.require(:information_item).permit(:header, :description, :link, :pinned, :publish)
  end
end
