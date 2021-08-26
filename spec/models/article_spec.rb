RSpec.describe Article, type: :model do
  describe 'Factory' do
    it 'is expected to have valid Factory' do
      expect(create(:article)).to be_valid
    end
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:author).class_name('User') }
  end

  describe 'Database' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:body).of_type(:text) }
    it { is_expected.to have_db_column(:published).of_type(:boolean) }
    it { is_expected.to have_db_column(:author_id).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end
end
