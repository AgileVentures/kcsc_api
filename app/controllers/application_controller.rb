class ApplicationController < ActionController::API
  before_action :authenticate_request
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  include PunditHelpers

  private

  def authenticate_request
    api_key = request.env['API_KEY'] || request.env['HTTP_API_KEY']
    unless Rails.application.credentials.client_api_keys.include? api_key
      render json: { message: 'wrong api key' },
             status: :unauthorized
    end
  end
end
