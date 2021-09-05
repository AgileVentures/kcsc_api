class InformationController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]

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

  def update
    information_item = InformationItem.find(params[:id])
    if information_item.update(information_item_params)
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
