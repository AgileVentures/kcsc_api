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
      fixnumify(params.require(:value).permit!.to_h.symbolize_keys)
    else
      params.require(:value).permit!
    end
  end

  # this is a hack that does not work!! 
  def fixnumify(obj)
    if obj.respond_to? :to_i
      # If we can cast it to a Fixnum, do it.
      obj.to_i

    elsif obj.is_a? Array
      # If it's an Array, use Enumerable#map to recursively call this method
      # on each item.
      obj.map { |item| fixnumify item }

    elsif obj.is_a? Hash
      # If it's a Hash, recursively call this method on each value.
      obj.merge(obj) { |_k, val| fixnumify val }
    elsif obj.is_a? String
      obj
    else
      # If for some reason we run into something else, just return
      # it unmodified; alternatively you could throw an exception.
      obj

    end
  end
end
