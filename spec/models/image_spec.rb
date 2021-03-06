RSpec.describe Image, type: :model do
  let(:article) { build(:article) }
  describe 'Factory' do
    it 'is expected to have valid basic Factory' do
      expect(create(:image, article: article)).to be_valid
    end

    it 'is expected to have valid basic Factory' do
      expect(build(:associated_image)).to be_valid
    end

    it 'is expected to have valid basic Factory' do
      expect(build(:card_logo)).to be_valid
    end
  end
  describe 'db table' do
    it { is_expected.to have_db_column(:alt_text).of_type(:string) }
    it { is_expected.to have_db_column(:article_id).of_type(:integer) }
  end

  describe 'Relationships' do
    it { is_expected.to belong_to(:article).optional }
    it { is_expected.to belong_to(:section).optional }
    it { is_expected.to have_one_attached(:file) }
  end

  describe '#image' do
    subject { create(:image, article: article).file }

    it {
      is_expected.to be_an_instance_of ActiveStorage::Attached::One
    }
  end
end
