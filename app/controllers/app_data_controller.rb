class AppDataController < ApplicationController
  before_action :authenticate_user!, only: %i[update destroy]
  before_action :parse_params, only: %i[update]
  def show
    render json: AppData.as_json
  end

  def update
    AppData.update(@key, @value)
    render json: { message: "#{@key} info has been updated" }
  rescue StandardError => e
    render json: { error: e }, status: 422
  end

  def destroy
    testimonial_id = params[:id].to_i
    AppData.delete(testimonial_id)
    render json: { message: "Testimonial id:#{testimonial_id} has been deleted" }
  rescue StandardError => e
    render json: { message: e.message }, status: 422
  end

  private

  def parse_params
    @key = params[:key].to_sym
    @value = permitted_value
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
