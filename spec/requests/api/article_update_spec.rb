RSpec.describe 'PUT /api/articles/:id' do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:valid_auth_headers_for_user) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key }.merge!(credentials) }
  let(:article) { create(:article, author: user) }

  subject { response }

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
