class AppDataController < ApplicationController
  def index
    render json: AppData.as_json
  end
end
