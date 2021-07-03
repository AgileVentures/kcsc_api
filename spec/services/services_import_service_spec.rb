RSpec.describe ServicesImportService do
  let!(:expected_service_count) { 337 }
  let!(:removed_services_count) { 1 }
  context '#import' do
    it 'is expected to create instances of Service' do
      expect do
        ServicesImportService.import
      end.to change { Service.count }.by expected_service_count
    end
  end

  context 'second run of #import' do
    before do
      ServicesImportService.import
      stub_request(:get, %r{/api/self-care/all})
        .to_return(status: 200, body: file_fixture('kcsc_api_response_organizations_updated.json').read, headers: {})
      stub_request(:get, %r{/api/self-care/addresses/all})
        .to_return(status: 200, body: file_fixture('kcsc_api_response_addresses_updated.json').read, headers: {})
      ServicesImportService.import
      @service = Service.find_by name: 'Access Group'
    end

    it 'is expected to update the count of services' do
      expect(Service.count).to eq expected_service_count - removed_services_count
    end

    it 'is expected to change description of existing service' do
      expect(@service.description).to eq 'Make Kensington and Chelsea great again.'
    end

    it 'is expected to change address of service' do
      expect(@service.address).to eq 'Hornton St London'
    end

    it 'is expected to change geocoded status of service' do
      expect(@service.geocoded?).to eq true
    end
  end
end
