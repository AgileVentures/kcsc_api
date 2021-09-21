class CardsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update]

  def create
    card = Card.create(card_params)
    if card.persisted? && attach_image(card)
      render json: card, serializer: Card::ShowSerializer, status: 201
    else
      render_error(card)
    end
  end

  def update    
    card = Card.find(params[:id])
    update_image(card) if params[:card][:logo].present?
    if card.update(card_params)
      render json: card, serializer: Card::ShowSerializer
    else
      render_error(card)
    end
  end

  private

  def render_error(card)
    render json: { message: card.errors.full_messages.to_sentence }, status: 422
  end

  def card_params
    params.require(:card).permit(:organization, :description, :section_id, :published, :web, :facebook,
                                 :twitter)
  end

  def attach_image(card)
    params[:card][:logo].present? && DecodeService.attach_image(params[:card][:logo],
                                                                Image.create(card: card, alt_text: params[:card][:alt]))
  end

  def update_image(card)
    DecodeService.attach_image(params[:card][:logo], card.image) unless params[:card][:logo].include? 'http'
    card.image.update(alt_text: params[:card][:alt])
  end
end
