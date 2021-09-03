RSpec.describe Section, type: :model do
  describe 'Factory' do
    it 'is expected to have valid basic Factory' do
      expect(create(:section)).to be_valid
    end
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:header) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:view) }
  end

  describe 'Database' do
    it { is_expected.to have_db_column(:header).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:variant).of_type(:integer) }
    it { is_expected.to have_db_column(:view_id).of_type(:integer) }
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:variant).with_values([:services, :about_us, :about_self_care, :information]) }
  end
end