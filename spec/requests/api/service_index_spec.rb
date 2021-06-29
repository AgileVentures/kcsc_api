RSpec.describe 'GET /api/services', type: :request do
  
  let!(:services) { ServicesImportService.import }

  before do
    get '/api/services'
  end

  it 'is expected to respond with status 200' do
    expect(response).to have_http_status 200
  end

  it 'is expected to respond with a list of 337 services' do
    expect(response_json['services'].count).to eq 337
  end
end