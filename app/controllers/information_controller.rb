class InformationController < ApplicationController
  def index
    information_items = InformationItem.all
    render json: { information_items: information_items }
  end
end
