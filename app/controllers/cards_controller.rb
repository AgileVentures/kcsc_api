class CardsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def create
    card = Card.create(card_params)
    if card.persisted? && attach_image(card)
      render json: card, serializer: Card::ShowSerializer, status: 201
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
end
