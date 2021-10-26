RSpec.describe 'GET /sections?view=:view_name', type: :request do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let!(:about_view) { create(:view, name: 'about') }
  let!(:sections) do
    create_list(:section, 2, view: about_view, variant: :regular) do |section, i|
      section.order = 2 - i
    end
  end

  subject { response }

  describe 'with valid api key' do
    before do
      get "/api/sections?view=#{about_view.name}", headers: { API_KEY: api_key }
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to return a list of sections' do
      expect(response_json['sections'].length).to eq(2)
    end

    it 'is expected to return a list of sections sorted by order' do
      expected_outcome = [{ order: 1 }, { order: 2 }]
      expect(response_json['sections']).to eq(expected_outcome)
    end
  end
end
