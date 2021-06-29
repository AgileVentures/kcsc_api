RSpec.describe 'POST /api/ahoy/visits', type: :request do
  let(:visitor_token) { SecureRandom.uuid }
  let(:visit_token) { SecureRandom.uuid }
  let(:visit_data) do
    { visit_token: visit_token,
      visitor_token: visitor_token,
      js: true,
      platform: 'Web',
      screen_height: 1080,
      screen_width: 1920,  
    }.to_json
  end
  let(:visit_headers) do
    {
      'Ahoy-Visit': visit_token,
      'Ahoy-Visitor': visitor_token,
      'Content-Type': 'application/json',
      'HTTP_USER_AGENT': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.101 Safari/537.36'
    }
  end

  before do
    post '/api/ahoy/visits', params: visit_data, headers: visit_headers
    @visit = Ahoy::Visit.last
  end

  it 'is expected to create a Visit' do
    expect(@visit).to be_an_instance_of Ahoy::Visit
  end

end
