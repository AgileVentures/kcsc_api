source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'active_model_serializers'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'slack-notify'
# gem 'devise_token_auth'
gem 'devise_token_auth', github: 'lynndylanhurley/devise_token_auth', branch: 'master'
gem 'pundit'
gem 'pundit_helpers'
gem 'aasm'
gem 'ahoy_matey'
gem 'rest-client'
gem 'chewy'
gem 'geocoder'

group :development, :test do
  gem 'coveralls', require: false
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'webmock'
  gem 'elasticsearch-extensions'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end
