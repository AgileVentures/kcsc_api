RSpec.describe 'GET /sections?view=:view_name', type: :request do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let!(:about_view) { create(:view, name: 'about') }
  let!(:sections) { create_list(:section, 3, view: about_view, variant: :about_us) }
  subject { response }

  
  describe 'with valid api key' do
    before do
      get "/api/sections?view=#{about_view.name}", headers: { API_KEY: api_key }
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to return a list of sections' do
      expect(response_json['sections'].length).to eq(3)
    end
  end
end
