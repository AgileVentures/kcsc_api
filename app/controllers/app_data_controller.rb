class AppDataController < ApplicationController
  before_action :authenticate_user!, only: [:update]
  def show
    render json: AppData.as_json
  end

  def update
    key = params[:key].to_sym
    value = permitted_value
    begin
      AppData.update(key, value)
      # AppData.update(key, value.to_h.symbolize_keys)
      render json: AppData.send(key)
    rescue StandardError => e
      render json: { error: e }, status: 422
    end
  end

  def permitted_value
    if params[:value].is_a? String
      params[:value]
    elsif params[:value].respond_to? :keys
      Number.convert(params.require(:value).permit!.to_h.symbolize_keys)
    else
      params.require(:value).permit!
    end
  end
end


