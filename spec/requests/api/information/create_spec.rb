RSpec.describe 'POST /api/information' do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:valid_auth_headers_for_user) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key }.merge!(credentials) }

  subject { response }

  context 'with valid auth headers and params' do
    before do
      post '/api/information',
           params: { information_item:
            { header: 'Test Info', description: 'This is a test information item', link: 'http://test.com', pinned: false, publish: true} },
           headers: valid_auth_headers_for_user
    end

    it { is_expected.to have_http_status(:created) }

    it 'is expected to return the information item header' do
      expect(response_json['information_item']['header']).to eq 'Test Info'
    end

    it 'is expected to return the information item description' do
      expect(response_json['information_item']['description']).to eq 'This is a test information item' 
    end

    it 'is expected to return the information item link' do
      expect(response_json['information_item']['link']).to eq 'http://test.com' 
    end

    it 'is expected to set pinned to false' do
      expect(response_json['information_item']['pinned']).to eq false
    end

    it 'is expected to set publish to false' do
      expect(response_json['information_item']['publish']).to eq true
    end
  end

  describe 'unsuccessfully' do
    describe 'with invalid auth headers' do
      let(:invalid_auth_headers) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key } }

      before do
        post '/api/information',
             params: { information_item:
              { header: 'Test Info', description: 'This is a test information item', link: 'http://test.com', pinned: false, publish: true} },
             headers: invalid_auth_headers
      end

      it { is_expected.to have_http_status(:unauthorized) }

      it 'is expected to return error message' do
        expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
      end
    end

    describe 'without passing validation' do
      before do
        post '/api/information',
             params: { information_item:
              { header: '', description: '', link: '', pinned: false, publish: true} },
             headers: valid_auth_headers_for_user
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }

      it 'is expected to return error message' do
        expect(response_json['message']).to eq "Header can't be blank, Description can't be blank, and Link can't be blank"
      end
    end
  end
end
