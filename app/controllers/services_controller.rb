class ServicesController < ApplicationController
  before_action :authenticate_request

  def index
    services = Service.all
    render json: services, each_serializer: Service::IndexSerializer
  end
end
