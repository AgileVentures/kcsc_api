RSpec.describe 'GET /api/information', type: :request do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let!(:information_items) { 3.times { create(:information_item) } }

  subject { response }

  describe 'with valid api key' do
    before do
      get '/api/information', headers: { API_KEY: api_key }
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to respond with a list of 3 information items' do
      expect(response_json['information_items'].count).to eq 3
    end
  end

  describe 'with invalid api key' do
    before do
      get '/api/information', headers: { API_KEY: 'invalid_key' }
    end

    it { is_expected.to have_http_status 401 }

  end
end
