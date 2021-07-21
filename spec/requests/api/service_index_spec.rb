RSpec.describe 'GET /api/services', type: :request do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let!(:services) { ServicesImportService.import }

  describe 'with a valid api key' do    
    before do
      get '/api/services', headers: { 'API_KEY' => api_key }
    end
  
    it 'is expected to respond with status 200' do
      expect(response).to have_http_status 200
    end
  
    it 'is expected to respond with a list of 337 services' do
      expect(response_json['services'].count).to eq 337
    end
  end

  describe 'with a invalid api key' do    
    before do
      get '/api/services', headers: { 'API_KEY' => 'whatever'}
    end
  
    it 'is expected to respond with status 401' do
      expect(response).to have_http_status 401
    end
  
    it 'is expected to respond with an error message' do
      expect(response_json['message']).to eq 'wrong api key'
    end
  end
end
