RSpec.describe Service::IndexSerializer, type: :serializer do
  let(:service) { create(:service) }
  let(:serialization) do
    ActiveModelSerializers::SerializableResource.new(
      service,
      serializer: described_class
    )
  end
  subject { JSON.parse(serialization.to_json) }

  it 'is expected to wrap content in key reflecting model name' do
    expect(subject.keys).to match ['service']
  end

  it 'is expected to contain relevant keys' do
    expected_keys = %w[id name description telephone email address postcode website coords]
    expect(subject['service'].keys).to match expected_keys
  end

  it 'is expected to have a specific structure' do
    expect(subject).to match(
      'service' => {
        'id' => be_a(Integer),
        'name' => be_a(String),
        'description' => be_a(String),
        'telephone' => be_a(String),
        'email' => a_string_including('@'),
        'address' => be_a(String),
        'postcode' => be_a(String),
        'website' => be_a(String),
        'coords' => {
          'latitude' => be_a(Float),
          'longitude' => be_a(Float)
        }
      }
    )
  end
end
