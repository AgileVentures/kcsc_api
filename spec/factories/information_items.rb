FactoryBot.define do
  factory :information_item do
    header { "MyString" }
    description { "MyText" }
    link { "MyText" }
    pinned { true }
    publish { true }
  end
end
