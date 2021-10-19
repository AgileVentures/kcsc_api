RSpec.describe 'GET /api/articles', type: :request do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let!(:articles) { create_list(:associated_image, 5) }
  let!(:articles_unpublished) { create(:article, published: false) }
  let!(:case_study) { create(:article, published: false, case_study: true) }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:valid_auth_headers_for_user) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key }.merge!(credentials) }

  subject { response }

  describe 'with valid api key to admin client' do
    before do
      get '/api/articles', headers: valid_auth_headers_for_user
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to respond with a list of 6 articles' do
      expect(response_json['articles'].count).to eq 6
    end
  end

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
