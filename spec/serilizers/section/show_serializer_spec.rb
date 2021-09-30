RSpec.describe Section::ShowSerializer, type: :serializer do
  let(:serialization) do
    ActiveModelSerializers::SerializableResource.new(
      sections,
      each_serializer: described_class
    )
  end
  subject { JSON.parse(serialization.to_json) }

  context 'response wrapper' do
    let(:sections) { create_list(:no_image, 2) }

    it 'is expected to reflect model name' do
      expect(subject.keys).to match ['sections']
    end
  end

  context ':regular' do    
    let(:sections) { create_list(:regular, 2, buttons: [create(:button)]) }
    let!(:image_1) {create(:image, section: sections.first)}
    let!(:image_2) {create(:image, section: sections.second)}
    it 'is expected to contain relevant keys for each object' do
      expected_keys = %w[variant header view_id id buttons description image]
      expect(subject['sections'].last.keys).to match expected_keys
    end

    it 'is expected to contain attached image' do
      expect(subject['sections'].first['image']['id']).to eq image_1.id
    end
  end

  context ':no_image' do
    let(:sections) { create_list(:no_image, 2) }
    it 'is expected to contain relevant keys for each object' do
      expected_keys = %w[variant header view_id id description]
      expect(subject['sections'].last.keys).to match expected_keys
    end
  end

  context ':carousel' do
    let(:sections) { create_list(:carousel, 2, cards: [create(:card)]) }
    it 'is expected to contain relevant keys for each object' do
      expected_keys = %w[variant header view_id id cards]
      expect(subject['sections'].last.keys).to match expected_keys
    end
  end
end
