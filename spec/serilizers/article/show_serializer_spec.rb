RSpec.describe Article::ShowSerializer, type: :serializer do
  let(:article) { create(:article) }
  let(:serialization) do
    ActiveModelSerializers::SerializableResource.new(article, serializer: described_class)
  end

  subject { JSON.parse(serialization.to_json) }

  it 'is expected to wrap content in key reflecting model name' do
    expect(subject.keys).to match ['article']
  end

  it 'is expected to contain relevant keys for the object' do
    expected_keys = %w[id title body date image]
    expect(subject['article'].keys).to match expected_keys
  end
end
