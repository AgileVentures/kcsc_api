require_relative 'boot'

require 'rails'
require 'active_storage/engine'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require_relative '../lib/convert'
Bundler.require(*Rails.groups)

module KCSCApi
  class Application < Rails::Application
    config.exceptions_app = routes
    config.action_mailer.delivery_method = 'smtp'
    config.action_mailer.smtp_settings = {
      port: 587,
      user_name: 'apikey',
      password: Rails.application.credentials.sendgrid_api_key,
      address: 'smtp.sendgrid.net',
      domain: 'heroku.com',
      authentication: 'plain'
    }
    config.action_mailer.default_url_options = { host: 'https://kcsc-api.herokuapp.com' }

    config.load_defaults 6.1
    config.api_only = true
    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.skip_routes false
      generate.routing_specs false
      generate.controller_specs false
      generate.request_specs false
    end
  end
end
