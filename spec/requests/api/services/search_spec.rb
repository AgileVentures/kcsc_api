RSpec.describe 'POST /api/search/:q', type: %i[request search_request] do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let!(:service_1) { create(:service, name: 'Boy Scouts') }
  let!(:service_2) { create(:service, description: 'We help boys come to terms with their masculinity') }
  let!(:service_3) { create(:service, email: 'boys-will-be-boys@mail.com') }
  let!(:service_4) { create(:service, email: 'girls-will-be-girls@mail.com') }
  let!(:service_5) { create(:service, description: 'We help girls come to terms with their femininity') }

  before do
    ServicesIndex.reset!
    wait_for_index(ServicesIndex)
  end
  describe 'with a valid api key' do
    before do
      post '/api/search',
           params: {
             q: 'Boy'
           },
           headers: { API_KEY: api_key }
    end

    it 'is expected to return return a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return 3 services' do
      expect(response_json['services'].count).to eq 3
    end
  end

  describe 'with a invalid api key' do
    before do
      post '/api/search',
           params: {
             q: 'Boy'
           },
           headers: { API_KEY: 'whatever' }
    end

    it 'is expected to return return a 401 response' do
      expect(response).to have_http_status 401
    end

    it 'is expected to return an error message' do
      expect(response_json['message']).to eq 'wrong api key'
    end
  end

  describe 'bad query' do
    before do
      post '/api/search',
           params: {
             q: 'Toast'
           },
           headers: { 'API_KEY': api_key }
    end

    it 'is expected to return a 404 response' do
      expect(response).to have_http_status 404
    end

    it 'is expected to return a error message' do
      expect(response_json['message']).to eq 'Your search yielded no results'
    end
  end
end
