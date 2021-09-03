RSpec.describe Section::ShowSerializer, type: :serializer do
  let(:sections) { create_list(:section, 3) }
  let(:serialization) do
    ActiveModelSerializers::SerializableResource.new(
      sections,
      each_serializer: described_class
    )
  end
  subject { JSON.parse(serialization.to_json) }

  it 'is expected to wrap content in key reflecting model name' do
    expect(subject.keys).to match ['sections']
  end

  it 'is expected to contain relevant keys for each object' do
    expected_keys = %w[variant header description]
    expect(subject['sections'].last.keys).to match expected_keys
  end
end
