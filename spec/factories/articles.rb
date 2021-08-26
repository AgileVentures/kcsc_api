FactoryBot.define do
  factory :article do
    title { "MyString" }
    body { "MyText" }
    published { true }
    association :author, factory: :user 
  end
end
