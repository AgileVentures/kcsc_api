RSpec.describe 'POST /cards', type: :request do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let!(:section) { create(:carousel) }
  let(:image) do
    File.read(fixture_path + '/files/image.txt')
  end
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:valid_auth_headers_for_user) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key }.merge!(credentials) }

  subject { response }

  describe 'with valid api key' do
    before do
      post '/api/cards', params: { card: { organization: 'new organization',
                                           description: 'whatever',
                                           section_id: section.id,
                                           published: true,
                                           logo: image,
                                           alt: 'alt attribute' } },
                         headers: valid_auth_headers_for_user
    end

    it { is_expected.to have_http_status 201 }

    describe 'is expected to return an updated resource' do
      it 'including organization' do
        expect(response_json['card']['organization']).to eq 'new organization'
      end

      it 'including a section_id' do
        expect(response_json['card']['section_id']).to eq section.id
      end

      it 'including a logo' do
        expect(response_json['card']['logo']).not_to be nil
      end

      it 'including an alt' do
        expect(response_json['card']['alt']).to eq 'alt attribute'
      end

      it 'including published attr' do
        expect(response_json['card']['published']).to eq true
      end
    end
  end

  describe 'unsuccessfully' do
    describe 'with invalid auth headers' do
      let(:invalid_auth_headers) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key } }

      before do
        post '/api/cards', params: { card: { organization: 'new organization',
                                             description: 'whatever',
                                             section_id: section.id,
                                             published: true,
                                             logo: image,
                                             alt: 'alt attribute' } },
                           headers: invalid_auth_headers
      end

      it { is_expected.to have_http_status(:unauthorized) }

      it 'is expected to return error message' do
        expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
      end
    end

    describe 'without passing validation' do
      before do
        post '/api/cards', params: { card: { organization: '',
                                             description: 'whatever',
                                             section_id: section.id,
                                             published: true,
                                             logo: image,
                                             alt: 'alt attribute' } },
                           headers: valid_auth_headers_for_user
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }

      it 'is expected to return error message' do
        expect(response_json['message']).to eq "Organization can't be blank"
      end
    end
  end
end
