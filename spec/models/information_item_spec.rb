RSpec.describe InformationItem, type: :model do
  describe 'Factory' do
    it 'is expected to have valid basic Factory' do
      expect(create(:information_item)).to be_valid
    end
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:header) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:link) }
    it { is_expected.to validate_inclusion_of(:pinned).in_array([false, true]) }
    it { is_expected.to validate_inclusion_of(:publish).in_array([false, true]) }
  end

  describe 'Database' do
    it { is_expected.to have_db_column(:header).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:link).of_type(:text) }
    it { is_expected.to have_db_column(:pinned).of_type(:boolean) }
    it { is_expected.to have_db_column(:publish).of_type(:boolean) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end
end
