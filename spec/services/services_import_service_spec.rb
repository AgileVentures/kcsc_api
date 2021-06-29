RSpec.describe ServicesImportService do
  context '#import' do    
    it 'is expected to create instances of Service' do
      expect do
        ServicesImportService.import
      end.to change { Service.count }.by 337
    end
  end
end
