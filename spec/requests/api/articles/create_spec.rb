RSpec.describe 'POST /api/articles' do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let(:user) { create(:user) }
  let(:image) do
    File.read(fixture_path + '/files/image.txt')
  end
  let(:credentials) { user.create_new_auth_token }
  let(:valid_auth_headers_for_user) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key }.merge!(credentials) }

  subject { response }

  context 'with valid auth headers and params' do
    before do
      post '/api/articles',
           params: { article:
            { title: 'Test Article', body: 'This is a test article', image: image, alt: 'alt' } },
           headers: valid_auth_headers_for_user
    end

    it { is_expected.to have_http_status(:created) }

    it 'is expected to return the article title' do
      expect(response_json['article']['title']).to eq 'Test Article'
    end

    it 'is expected to return the article body' do
      expect(response_json['article']['body']).to eq 'This is a test article' 
    end

    it 'is expected to return the article author' do
      expect(response_json['article']['author']['name']).to eq Article.last.author.name
    end

    it 'is expected to set published to true' do
      expect(response_json['article']['published']).to eq true
    end

    it 'is expected to set alt attribute of image' do
      expect(response_json['article']['image']['alt']).to eq 'alt'
    end
  end

  describe 'unsuccessfully' do
    describe 'with invalid auth headers' do
      let(:invalid_auth_headers) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key } }

      before do
        post '/api/articles',
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
        post '/api/articles',
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

  context 'creating a case_study entry' do
    
    before do
      post '/api/articles',
           params: { article:
            { title: 'case study 1', body: 'This is a case study', case_study: true, image: image, alt: 'alt' } },
           headers: valid_auth_headers_for_user
    end

    it { is_expected.to have_http_status(:created) }

    it 'is expected to save an Article as case study' do
      expect(response_json['article']['case_study']).to eq true
    end
  end
end
