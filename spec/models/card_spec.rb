RSpec.describe Card, type: :model do
  let(:image) { build(:image) }
  describe 'Factory' do
    it 'is expected to have valid basic Factory' do
      expect(create(:card, image: image)).to be_valid
    end
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:organization) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:section) }
    it { is_expected.to have_one(:image) }
  end

  describe 'Database' do
    it { is_expected.to have_db_column(:organization).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:published).of_type(:boolean) }
    it { is_expected.to have_db_column(:web).of_type(:string) }
    it { is_expected.to have_db_column(:facebook).of_type(:string) }
    it { is_expected.to have_db_column(:twitter).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end
end