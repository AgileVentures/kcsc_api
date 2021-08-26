RSpec.describe 'GET /api/articles/:id', type: :request do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let!(:article_1) { create(:article, title: 'My Awesome Article') }

  subject { response }
  describe 'with valid api key' do
    before do
      get "/api/articles/#{article_1.id}", headers: { API_KEY: api_key }
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to respond with the right article title' do
      expect(response_json['article'])
        .to have_key('title')
        .and have_value('My Awesome Article')
    end
  end

  describe 'with invalid api key' do
    before do
      get "/api/articles/#{article_1.id}", headers: { API_KEY: 'invalid_key' }
    end

    it { is_expected.to have_http_status 401 }
  end
end
