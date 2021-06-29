FactoryBot.define do
  factory :ahoy_visit, class: 'Ahoy::Visit' do
    visit_token { SecureRandom.uuid }
    visitor_token { SecureRandom.uuid }
    ip { '121.0.0.2' }
  end
end
