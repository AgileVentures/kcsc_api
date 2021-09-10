RSpec.describe Section, type: :model do
  describe 'Factories' do
    context 'basic section' do
      subject { create(:section) }
      it { is_expected.to be_valid }
      it 'is expected to store nil as numeric value for variant' do
        expect(subject.variant).to eq nil
      end
    end

    context 'regular section' do
      subject { create(:regular) }
      it { is_expected.to be_valid }
      it 'is expected to store 0 as numeric value for variant' do
        expect(subject.variant_before_type_cast).to eq 0
      end
    end

    context 'no_image section' do
      subject { create(:no_image) }
      it { is_expected.to be_valid }
      it 'is expected to store 1 as numeric value for variant' do
        expect(subject.variant_before_type_cast).to eq 1
      end
    end

    context 'carousel section' do
      subject { create(:carousel) }
      it { is_expected.to be_valid }
      it 'is expected to store 2 as numeric value for variant' do
        expect(subject.variant_before_type_cast).to eq 2
      end
    end
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:header) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:view) }
    it {
      is_expected.to have_one(:image)
        .dependent(:destroy_async)
    }
    context 'regular' do
      subject { create(:regular) }
      it {
        is_expected.to have_many(:buttons)
          .dependent(:destroy)
          .class_name('Cta')
      }
    end
  end

  describe 'Database' do
    it { is_expected.to have_db_column(:header).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:variant).of_type(:integer) }
    it { is_expected.to have_db_column(:view_id).of_type(:integer) }
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:variant).with_values(%i[regular no_image carousel]) }
  end
end
