RSpec.describe 'PUT /api/information/:id' do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:valid_auth_headers_for_user) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key }.merge!(credentials) }
  let(:information_item) { create(:information_item, publish: false) }

  subject { response }
  
  describe 'with valid auth headers and params' do
    describe 'for changing header' do
      before do
        put "/api/information/#{information_item.id}",
            params: { information_item: { header: 'New Header' } },
            headers: valid_auth_headers_for_user
      end
  
      it { is_expected.to have_http_status 200 }
  
      it 'is expected to update the information item header' do
        expect(information_item.reload.header).to eq 'New Header'
      end
    end

    describe 'for publishing information item' do
      before do
        put "/api/information/#{information_item.id}",
            params: { information_item: { publish: true } },
            headers: valid_auth_headers_for_user
      end
  
      it { is_expected.to have_http_status 200 }
  
      it 'is expected to publish the information item' do
        expect(information_item.reload.publish).to eq true
      end
    end
  end

  describe 'unsuccessfully' do
    describe 'with invalid auth headers' do
      let(:invalid_auth_headers) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key } }

      before do
        put "/api/information/#{information_item.id}",
             params: { information_item:
              { header: 'Test Info Item', description: 'This is a test info item' } },
             headers: invalid_auth_headers
      end

      it { is_expected.to have_http_status(:unauthorized) }

      it 'is expected to return error message' do
        expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
      end
    end

    describe 'without passing validation' do
      before do
        put "/api/information/#{information_item.id}",
             params: { information_item:
              { header: '', description: '' } },
             headers: valid_auth_headers_for_user
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }

      it 'is expected to return error message' do
        expect(response_json['message']).to eq "Header can't be blank"
      end
    end
  end
end
