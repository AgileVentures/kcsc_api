FactoryBot.define do
  factory :inquiry do
    size { 5 }
    office_type { 1 }
    inquiry_status { 1 }
    peers { 'Yes' }
    email { 'mrfake@fake.com' }
    flexible { 1 }
    phone { '0707123456' }
    locations { %w[Nordstaden Avenyn] }
    start_date { 1 }
    started_email_sent { false }
    language { 'en' }
  end
end
