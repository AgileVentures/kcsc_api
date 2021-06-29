RSpec.describe 'GET, api/analytics', type: :request do
  let!(:visit_1) { create(:ahoy_visit) }
  let!(:visit_2) { create(:ahoy_visit) }

  before do
    get '/api/analytics'
  end

  it 'is expected to return a total number of visits' do
    expect(response_json['statistics']['visits']['total']).to eq 2
  end


end
