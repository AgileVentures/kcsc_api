require 'coveralls'
Coveralls.wear_merged!('rails')
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
require 'webmock/rspec'
require 'elasticsearch/extensions/test/cluster'
require 'chewy/rspec'
WebMock.disable_net_connect!(allow_localhost: true)
require 'slack-notify'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }
abort('The Rails environment is running in production mode!') if Rails.env.production?

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

module ChewyHelper
  def wait_for_index(index)
    index.client.perform_request(:post, "#{index.index_name}/_flush")
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include Shoulda::Matchers::ActiveRecord, type: :model
  config.include ResponseJSON
  config.include ChewyHelper, type: :search_request
  config.before(:each) do
    stub_request(:post, Rails.application.credentials.dig(:slack, :webhook_url))
      .to_return(status: 200, body: 'true', headers: {})
    stub_request(:get, %r{/api/self-care/all})
      .to_return(status: 200, body: file_fixture('kcsc_api_response_organizations.json').read, headers: {})
    stub_request(:get, %r{/api/self-care/addresses/all})
      .to_return(status: 200, body: file_fixture('kcsc_api_response_addresses.json').read, headers: {})
    stub_request(:get, %r{/maps.googleapis.com/maps/api/geocode/})
      .to_return(status: 200, body: file_fixture('google_geocode_api.json'), headers: {})
  end

  config.before(:suite) do
    Chewy.strategy(:bypass)
  end
end
