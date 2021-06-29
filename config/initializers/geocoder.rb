Geocoder.configure(
  # Geocoding options
  timeout: 3,                
  lookup: :google,        
  # API key for geocoding service
  api_key: Rails.application.credentials.google_map[:api_key],              
  # Calculation options
  # :km for kilometers or :mi for miles
  units: :km 
)
