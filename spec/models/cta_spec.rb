RSpec.describe Cta, type: :model do
  subject { create(:button, section: create(:regular)) }
  describe 'Factory' do
    it 'is expected to have valid basic Factory' do
      expect(create(:button)).to be_valid
    end
  end
  describe 'db table' do
    it { is_expected.to have_db_column(:text).of_type(:string) }
    it { is_expected.to have_db_column(:link).of_type(:string) }
    it { is_expected.to have_db_column(:section_id).of_type(:integer) }
  end
end
