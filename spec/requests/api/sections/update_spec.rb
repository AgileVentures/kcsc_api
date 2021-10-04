RSpec.describe 'PUT /sections/:id', type: :request do
  let!(:api_key) { Rails.application.credentials.client_api_keys[0] }
  let(:image) { create(:image) }
  let!(:section) { create(:section, variant: 0, image: image, header: 'old header') }
  let!(:button_1) { create(:button, section: section, text: 'button_1 old text', link: 'button_1 old link') }
  let!(:button_2) { create(:button, section: section, text: 'button_2 old text', link: 'button_2 old link') }
  let!(:section_without_image) { create(:section, variant: 0, image: nil, header: 'regular without an image image') }
  let!(:section_no_image) { create(:section, variant: 1, header: 'section no_image') }
  let!(:section_carousel) { create(:section, variant: 2, header: 'section carousel') }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:valid_auth_headers_for_user) { { HTTP_ACCEPT: 'application/json', API_KEY: api_key }.merge!(credentials) }

  subject { response }

  describe 'with valid auth headers and params' do
    describe 'by changing header' do
      before do
        put "/api/sections/#{section.id}", params: { section: { header: 'my new header' } },
                                           headers: valid_auth_headers_for_user
      end

      it { is_expected.to have_http_status 200 }

      it 'is expected to return an updated resource' do
        expect(response_json['section']['header']).to eq 'my new header'
      end
    end

    describe 'by changing picture' do
      let(:new_image) do
        File.read(fixture_path + '/files/new_image.txt')
      end

      describe 'for section WITH an image' do
        before do
          put "/api/sections/#{section.id}", params: { section: { image: new_image, alt: 'new alt' } },
                                             headers: valid_auth_headers_for_user
        end

        it 'is expected to respond with status 200' do
          expect(response).to have_http_status 200
        end

        it 'is expected to have the new image attached' do
          new_image_id = Section.find(section.id).image.file.attributes['id']
          old_image_id = section.image.file.attributes['id']
          expect(new_image_id).not_to eq old_image_id
        end

        it 'is expected to update alt attribute' do
          new_image_alt_text = Section.find(section.id).image.attributes['alt_text']
          expect(new_image_alt_text).to eq 'new alt'
        end
      end

      describe 'for section WITHOUT an image' do
        before do
          put "/api/sections/#{section_without_image.id}", params: { section: { image: new_image, alt: 'new alt' } },
                                                           headers: valid_auth_headers_for_user
        end

        it 'is expected to respond with status 200' do
          expect(response).to have_http_status 200
        end

        it 'is expected to have the new image attached' do
          expect(Section.find(section_without_image.id).image).not_to eq nil
        end

        it 'is expected to update alt attribute' do
          new_image_alt_text = Section.find(section_without_image.id).image.attributes['alt_text']
          expect(new_image_alt_text).to eq 'new alt'
        end
      end

      describe 'for section of type no_image' do
        before do
          put "/api/sections/#{section_no_image.id}", params: { section: { header: 'new header', image: new_image, alt: 'new alt' } },
                                                      headers: valid_auth_headers_for_user
        end

        it 'is expected to respond with status 200' do
          expect(response).to have_http_status 200
        end

        it 'is expected to return an updated resource' do
          expect(response_json['section']['header']).to eq 'new header'
        end

        it 'is expected not to attach image' do
          attached_image = Section.find(section_no_image.id).image
          expect(attached_image).to eq nil
        end
      end

      describe 'for section of type carousel' do
        before do
          put "/api/sections/#{section_carousel.id}", params: { section: { header: 'new header', image: new_image, alt: 'new alt' } },
                                                      headers: valid_auth_headers_for_user
        end

        it 'is expected to respond with status 200' do
          expect(response).to have_http_status 200
        end

        it 'is expected to return an updated resource' do
          expect(response_json['section']['header']).to eq 'new header'
        end

        it 'is expected not to attach image' do
          attached_image = Section.find(section_carousel.id).image
          expect(attached_image).to eq nil
        end
      end
    end

    describe 'by changing buttons' do
      let(:new_buttons) do
        [
          { id: button_1.id, text: 'button_1 new text', link: 'button_1 new link' },
          { id: button_2.id, text: 'button_2 new text', link: 'button_2 new link' }
        ]
      end
      before do
        put "/api/sections/#{section.id}", params: { section: { buttons: new_buttons } },
                                           headers: valid_auth_headers_for_user
      end

      it 'is expected to respond with status 200' do
        expect(response).to have_http_status 200
      end

      it 'is expected to update first button' do
        expect(response_json['section']['buttons'].first['text']).to eq 'button_1 new text'
      end

      it 'is expected to update second button' do
        expect(response_json['section']['buttons'].second['text']).to eq 'button_2 new text'
      end
    end
  end
end
