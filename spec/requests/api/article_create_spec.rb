RSpec.describe 'POST /api/articles' do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:valid_auth_headers_for_user) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key }.merge!(credentials) }

  subject { response }

  context 'with valid auth headers' do
    before do
      post '/api/articles',
           params: { article:
            { title: 'Test Article', body: 'This is a test article' } },
           headers: valid_auth_headers_for_user
    end

    it { is_expected.to have_http_status(:created) }

    it 'is expected to return the article title' do
      expect(response_json['article']['title']).to eq('Test Article')
    end

    it 'is expected to return the article body' do
      expect(response_json['article']['body']).to eq('This is a test article')
    end

    it 'is expected to return the article author' do
      expect(response_json['article']['author']['name']).to eq(Article.last.author.name)
    end
  end
end
