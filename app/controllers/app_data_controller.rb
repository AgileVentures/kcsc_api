class AppDataController < ApplicationController
  def show
    render json: AppData.as_json
  end

  def update
    key = params[:key].to_sym
    value = permitted_value
    begin
      AppData.update(key, value)
      render json: AppData.send(key)
    rescue StandardError => e
      render json: { error: e }, status: 422
    end
  end

  def permitted_value
    if params[:value].is_a? String
      params[:value]
    else
      params.require(:value).permit!
    end
  end
end
