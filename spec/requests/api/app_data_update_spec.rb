RSpec.describe 'PUT /api/app_data', type: :request do
  def reset_app_data
    File.open(Rails.root.join('lib', AppData::DATA_FILE), 'w') { |f| f.write data.to_yaml }
  end

  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:valid_auth_headers_for_user) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key }.merge!(credentials) }

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
    describe 'with valid authentication' do
      before do
        put '/api/app_data', params: { key: 'about',
                                       value: 'This is the new about section' },
                             headers: valid_auth_headers_for_user
      end

      it 'is expected to respond with status 200' do
        expect(response).to have_http_status 200
      end

      it 'is expected to update AppData.about' do
        expect(AppData.about).to eq 'This is the new about section'
      end
    end

    describe 'unauthenticated' do
      before do
        put '/api/app_data', params: { key: 'about',
                                       value: 'This is the new about section' },
                             headers: { HTTP_ACCEPT: 'application/json', API_KEY: api_key }
      end

      it 'is expected to respond with status 401' do
        expect(response).to have_http_status 401
      end
    end
  end

  describe '#disclaimers section' do
    describe 'with valid authentication' do
      before do
        put '/api/app_data', params: { key: 'disclaimers',
                                       value: { one: 'new value', two: 'another new value' } },
                             headers: valid_auth_headers_for_user
      end

      it 'is expected to respond with status 200' do
        expect(response).to have_http_status 200
      end

      it 'is expected to update AppData.disclaimers' do
        expect(AppData.disclaimers).to eq({ one: 'new value', two: 'another new value' })
      end
    end

    describe 'unauthenticated' do
      before do
        put '/api/app_data', params: { key: 'disclaimers',
                                       value: { one: 'new value', two: 'another new value' } },
                             headers: { HTTP_ACCEPT: 'application/json', API_KEY: api_key }
      end

      it 'is expected to respond with status 401' do
        expect(response).to have_http_status 401
      end
    end
  end
end
