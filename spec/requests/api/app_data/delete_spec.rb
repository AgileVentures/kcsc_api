RSpec.describe 'DELETE /api/app_data', type: :request do
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
      testimonials: [{ id: 1, foo: 'bar' }, { id: 2, foo: 'baz' }],
      disclaimers: { one: 'value', two: 'another value' }
    } }
  end

  before do
    stub_const('AppData::DATA_FILE', 'test_data.yml')
    reset_app_data
  end

  after { reset_app_data }

  describe '#testimonials section' do
    describe 'sending in an existing testimonial' do
      before do
        delete '/api/app_data', params: { id: 1 },
                                headers: valid_auth_headers_for_user
      end

      it 'is expected to respond with status 200' do
        expect(response).to have_http_status 200
      end

      it 'is expected to update AppData.testimonials' do
        expect(AppData.testimonials).to eq([{ id: 2, foo: 'baz' }])
      end
    end

    describe 'sending in an non-existing id' do
      before do
        delete '/api/app_data', params: { id: 3 },
                                headers: valid_auth_headers_for_user
      end

      it 'is expected to respond with status 422' do
        expect(response).to have_http_status 422
      end

      it 'is expected to throw an error' do
        expect(response_json['message']).to eq 'record not found'
      end
    end
  end
end
