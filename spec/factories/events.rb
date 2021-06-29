FactoryBot.define do
  factory :ahoy_event, class: 'Ahoy::Event' do
    visit factory: :ahoy_visit
    name { 'answer' }
    properties {}
    time { DateTime.now.utc }
  end
end
