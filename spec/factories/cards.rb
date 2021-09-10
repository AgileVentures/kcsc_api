FactoryBot.define do
  factory :card do
    organization { "MyString" }
    description { "MyText" }
    published { false }
    web { "MyString" }
    facebook { "MyString" }
    twitter { "MyString" }
    section
  end
end
