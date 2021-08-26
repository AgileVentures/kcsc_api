RSpec.describe 'PUT /api/articles/:id' do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:valid_auth_headers_for_user) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key }.merge!(credentials) }
  let(:article) { create(:article, author: user) }

  subject { response }
  
  context 'with valid auth headers and params' do
    before do
      put "/api/articles/#{article.id}",
          params: { article: { title: 'New Title' } },
          headers: valid_auth_headers_for_user
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to update the article title' do
      expect(article.reload.title).to eq 'New Title'
    end
  end

  describe 'unsuccessfully' do
    describe 'with invalid auth headers' do
      let(:invalid_auth_headers) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key } }

      before do
        put "/api/articles/#{article.id}",
             params: { article:
              { title: 'Test Article', body: 'This is a test article' } },
             headers: invalid_auth_headers
      end

      it { is_expected.to have_http_status(:unauthorized) }

      it 'is expected to return error message' do
        expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
      end
    end

    describe 'without passing validation' do
      before do
        put "/api/articles/#{article.id}",
             params: { article:
              { title: '', body: '' } },
             headers: valid_auth_headers_for_user
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }

      it 'is expected to return error message' do
        expect(response_json['message']).to eq "Title can't be blank and Body can't be blank"
      end
    end
  end
end
