class ServicesController < ApplicationController
  def index
    services = Service.all
    render json: {services: services}
  end
end
