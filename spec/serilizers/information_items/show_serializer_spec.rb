RSpec.describe InformationItem::ShowSerializer, type: :serializer do
  let(:information_item) { create(:information_item) }
  let(:serialization) do
    ActiveModelSerializers::SerializableResource.new(information_item, serializer: described_class)
  end

  subject { JSON.parse(serialization.to_json) }

  it 'is expected to wrap content in key reflecting model name' do
    expect(subject.keys).to match ['information_item']
  end

  it 'is expected to contain relevant keys for the object' do
    expected_keys = %w[id date header description link pinned publish]
    expect(subject['information_item'].keys).to match expected_keys
  end
end
