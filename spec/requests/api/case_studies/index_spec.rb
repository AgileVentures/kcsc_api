RSpec.describe 'GET /api/articles', type: :request do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let!(:article) { create(:article, case_study: false) }
  let!(:case_study) { create(:article, case_study: true) }

  subject { response }

  describe 'with valid api key' do
    before do
      get '/api/case_studies', headers: { API_KEY: api_key }
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to respond with a list of 1 case study' do
      expect(response_json['case_studies'].count).to eq 1
    end
  end
end
