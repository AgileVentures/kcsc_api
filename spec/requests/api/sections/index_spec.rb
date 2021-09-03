RSpec.describe 'GET /sections?view=:view_name', type: :request do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let!(:about_view) { create(:view, name: 'about') }
  let(:sections) { create_list(:section, 3, view: about_view) }
  describe 'with valid api key' do
    
    before do
      get "/sections?view=#{about_view}"
    end

    it { is_expected.to have_http_status 200 }

    it 'returns a list of sections' do
      expect(requast_json['sections']).to eq(3)
    end

  end
  

end