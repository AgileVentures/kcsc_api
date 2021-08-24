RSpec.describe 'PUT /api/app_data' do
  def reset_app_data
    File.open(Rails.root.join('lib', AppData::DATA_FILE), 'w') { |f| f.write data.to_yaml }
  end
  
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let(:data) do
    { app_data: {
      about: 'We are all about doing good',
      disclaimers: { one: 'value', two: 'another value' }
    } }
  end

  before do
    stub_const('AppData::DATA_FILE', 'test_data.yml')
    reset_app_data
  end

  after { reset_app_data }

  describe '#about section' do
    before do
      put '/api/app_data', params: { key: 'about',
                                     value: 'This is the new about section' },
                           headers: { 'API_KEY' => api_key }
    end

    it 'is expected to respond with status 200' do
      expect(response).to have_http_status 200
    end

    it 'is expected to update AppData.about' do
      expect(AppData.about).to eq 'This is the new about section'
    end
  end

  describe '#disclaimers section' do
    before do
      put '/api/app_data', params: { key: 'disclaimers',
                                     value: { one: 'new value', two: 'another new value' } },
                           headers: { 'API_KEY' => api_key }
    end

    it 'is expected to respond with status 200' do
      expect(response).to have_http_status 200
    end

    it 'is expected to update AppData.disclaimers' do
      expect(AppData.disclaimers).to eq({ one: 'new value', two: 'another new value' })
    end
  end
end
