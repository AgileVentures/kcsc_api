class AppDataController < ApplicationController
  before_action :authenticate_user!, only: [:update, :destroy]
  before_action :parse_params, only: [:update, :destroy]
  def show
    render json: AppData.as_json
  end

  def update
    begin
      AppData.update(@key, @value)
      render json: { message: "#{@key} info has been updated" }
    rescue StandardError => e
      render json: { error: e }, status: 422
    end
  end

  def destroy    
    begin      
      AppData.delete(@value)
      render json: { message: "Testimonial id:#{@value[:id]} has been deleted" }
    rescue StandardError => e
      render json: { message: e.message }, status: 422
    end
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
