RSpec.describe 'Visitor can search for recipes', type: %i[request search_request] do
  let!(:organization_1) { create(:organization, name: 'Boy Scouts') }
  let!(:organization_2) { create(:organization, description: 'We help boys come to terms with their masculinity') }
  let!(:organization_3) { create(:organization, email: 'boys-will-be-boys@mail.com') }
  let!(:organization_4) { create(:organization, email: 'girls-will-be-girls@mail.com') }
  let!(:organization_5) { create(:organization, description: 'We help girls come to terms with their femininity') }

  before do
    OrganizationsIndex.reset!
      wait_for_index(OrganizationsIndex)
  end
  describe 'successfully' do
    before do
      post '/api/search',
           params: {
             q: 'Boy'
           }
    end

    it 'is expected to return return a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return 3 organizations' do
      expect(response_json['organizations'].count).to eq 3
    end
  end

  describe 'bad query' do
    before do
      post '/api/search',
           params: {
             q: 'Toast'
           }
    end

    it 'is expected to return a 404 response' do
      expect(response).to have_http_status 404
    end

    it 'is expected to return a error message' do
      expect(response_json['message']).to eq 'Your search yielded no results'
    end
  end
end
