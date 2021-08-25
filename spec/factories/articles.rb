FactoryBot.define do
  factory :article do
    title { "MyString" }
    body { "MyText" }
    association :author, factory: :user 
  end
end
