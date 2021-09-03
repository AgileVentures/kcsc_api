RSpec.describe 'POST /sections/', type: :request do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let!(:about_view) { create(:view, name: 'about') }
  subject { response }

  describe 'with valid api key' do
    before do
      post '/api/sections', params: { section: { header: 'new header',
                                                 view_id: about_view.id,
                                                 description: 'whatever we need to use as a description' } },
                            headers: { API_KEY: api_key }
    end

    it { is_expected.to have_http_status 201 }

    describe 'is expected to return an updated resource' do
      
      it 'including a header' do
        expect(response_json['section']['header']).to eq 'new header'
      end

      it 'including a view_id' do
        expect(response_json['section']['view_id']).to eq about_view.id
      end

      it 'including a description' do
        expect(response_json['section']['description']).to eq 'whatever we need to use as a description'
      end
    end
  end
end
