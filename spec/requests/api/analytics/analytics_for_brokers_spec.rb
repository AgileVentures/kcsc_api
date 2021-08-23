RSpec.describe 'GET api/analytics', type: :request do
  let!(:visit_1) { create(:ahoy_visit) }
  let!(:visit_2) { create(:ahoy_visit) }
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }


  before do
    get '/api/analytics', headers: { 'API_KEY' => api_key }
  end

  it 'is expected to respond with status 200' do
    expect(response).to have_http_status 200
  end

  it 'is expected to return a total number of visits' do
    expect(response_json['statistics']['visits']['total']).to eq 2
  end
end
