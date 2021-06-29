class ServicesController < ApplicationController
  def index
    services = Service.all
    render json: services, each_serializer: Service::IndexSerializer
  end
end
