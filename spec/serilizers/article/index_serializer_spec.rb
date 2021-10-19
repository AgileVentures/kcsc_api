RSpec.describe Article::IndexSerializer, type: :serializer do
  let(:image) { create(:associated_image) }
  let(:articles) { create_list(:article, 3, image: image) }
  let(:serialization) do
    ActiveModelSerializers::SerializableResource.new(
      articles,
      each_serializer: described_class
    )
  end
  subject { JSON.parse(serialization.to_json) }

  it 'is expected to wrap content in key reflecting model name' do
    expect(subject.keys).to match ['articles']
  end

  it 'is expected to contain relevant keys for each object' do
    expected_keys = %w[id title teaser date image published case_study author]
    expect(subject['articles'].last.keys).to match expected_keys
  end

  describe 'custom root' do
    let(:serialization) do
      ActiveModelSerializers::SerializableResource.new(
        articles,
        each_serializer: described_class,
        root: 'custom_value'
      )
    end

    it 'is expected to wrap content in key reflecting the custom value' do
      expect(subject.keys).to match ['custom_value']
    end
  end
end
