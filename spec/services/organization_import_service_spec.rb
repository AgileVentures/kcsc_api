RSpec.describe OrganizationImportService do
  context '#import' do    
    it 'is expected to create instances of Organization' do
      expect do
        OrganizationImportService.import
      end.to change { Organization.count }.by 337
    end
  end
end
