RSpec.describe 'GET /api/information', type: :request do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let!(:information_items) { 3.times { create(:information_item) } }
  let!(:information_items_unpublished) { create(:information_item, publish: false) }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:valid_auth_headers_for_user) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key }.merge!(credentials) }

  subject { response }

  describe 'with valid api key to admin client' do
    before do
      get '/api/information', headers: valid_auth_headers_for_user
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to respond with a list of 4 information items' do
      expect(response_json['information_items'].count).to eq 4
    end
  end

  describe 'with valid api key to public client' do
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
