RSpec.describe Setting, type: :model do
  context '#contact' do
    it 'is expected to have a default contact information' do
      expected_value = {
        email: 'info@communityhealthwestlondon.org.uk',
        phone: '0207-243 9806'
      }
      expect(Setting.contact).to eq expected_value
    end
    it 'is expected to accept an latitude override' do
      Setting.create(key: 'latitude', value: '51.4959297')
      expect(Setting.latitude).to eq '51.4959297'
    end
  end
  context '#longitude' do
    it 'is expected to have a default longitude' do
      expect(Setting.longitude).to eq '-0.3370'
    end
    it 'is expected to accept an longitude override' do
      Setting.create(key: 'longitude', value: '-0.2100279')
      expect(Setting.longitude).to eq '-0.2100279'
    end
  end
  context '#meta_tag_title' do
    it 'is expected to have a default meta tag title' do
      expect(Setting.meta_tag_title).to eq 'KSCS Community'
    end
    it 'is expected to accept an meta tag title override' do
      Setting.create(key: 'meta_tag_title', value: 'KSCS Community Assets')
      expect(Setting.meta_tag_title).to eq 'KSCS Community Assets'
    end
  end
end
