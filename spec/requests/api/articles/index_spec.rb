RSpec.describe 'GET /api/articles', type: :request do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let!(:image) { create_list(:associated_image, 5) }

  subject { response }

  describe 'with valid api key' do
    before do
      get '/api/articles', headers: { API_KEY: api_key }
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to respond with a list of 5 articles' do
      expect(response_json['articles'].count).to eq 5
    end
  end

  describe 'with invalid api key' do
    before do
      get '/api/articles', headers: { API_KEY: 'invalid_key' }
    end

    it { is_expected.to have_http_status 401 }
  end
end
