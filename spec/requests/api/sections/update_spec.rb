RSpec.describe 'PUT /sections/:id', type: :request do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let!(:section) { create(:section, header: 'old header') }
  subject { response }

  describe 'with valid api key' do
    before do
      put "/api/sections/#{section.id}", params: { section: { header: 'my new header' } },
                                            headers: { API_KEY: api_key }
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to return an updated resource' do
      expect(response_json['section']['header']).to eq 'my new header'
    end
  end
end
