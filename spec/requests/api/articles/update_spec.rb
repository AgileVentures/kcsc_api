RSpec.describe 'PUT /api/articles/:id' do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:valid_auth_headers_for_user) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key }.merge!(credentials) }
  let(:image) { create(:associated_image) }
  let(:article) { create(:article, image: image, author: user, published: false) }

  subject { response }

  describe 'with valid auth headers and params' do
    describe 'for changing title' do
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

    describe 'for publishing article' do
      before do
        put "/api/articles/#{article.id}",
            params: { article: { published: true } },
            headers: valid_auth_headers_for_user
      end

      it { is_expected.to have_http_status 200 }

      it 'is expected to update the article title' do
        expect(article.reload.published).to eq true
      end
    end

    describe 'by changing the picture' do
      let(:new_image) do
        File.read(fixture_path + '/files/new_image.txt')
      end

      before do
        put "/api/articles/#{article.id}",
            params: { article: { image: new_image, alt: 'new alt' } },
            headers: valid_auth_headers_for_user
      end

      it 'is expected to response with status 200' do
        expect(response).to have_http_status 200
      end

      it 'is expected to have the new image attached' do
        new_image_id = Article.find(article.id).image.file.attributes['id']
        old_image_id = article.image.file.attributes['id']
        expect(new_image_id).not_to eq old_image_id
      end

      it 'is expected to update alt attribute' do
        new_image_alt_text = Article.find(article.id).image.attributes['alt_text']
        expect(new_image_alt_text).to eq 'new alt'
      end
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
