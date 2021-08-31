FactoryBot.define do
  factory :image do
    alt_text { "MyString" }
    association :article
  end
end
