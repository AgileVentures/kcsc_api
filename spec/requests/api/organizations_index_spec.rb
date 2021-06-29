RSpec.describe '', type: :request do
  
  let!(:organizations) { OrganizationImportService.import }

  before do
    get '/api/organizations'
  end

  it 'is expected to respond with status 200' do
    expect(response).to have_http_status 200
  end

  it 'is expected to respond with a list of 337 organizations' do
    expect(response_json['organizations'].count).to eq 337
  end
end