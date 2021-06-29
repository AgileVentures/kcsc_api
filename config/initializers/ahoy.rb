class Ahoy::Store < Ahoy::DatabaseStore
end

if Rails.env.test? 
  Ahoy.track_bots = true
  Ahoy.visit_duration = 3.seconds
end

# set to true for JavaScript tracking
Ahoy.api = false

Ahoy.api_only = true

# set to true for geocoding
# we recommend configuring local geocoding first
# see https://github.com/ankane/ahoy#geocoding
Ahoy.geocode = false
