FactoryBot.define do
  factory :organization do
    imported_at { "2021-06-29 11:36:15" }
    latitude { 1.5 }
    longitude { 1.5 }
    name { "MyString" }
    description { "MyText" }
    telephone { "MyString" }
    email { "MyString" }
    publish_address { false }
    publish_telephone { false }
    charity_commission_id { 1 }
    address { "MyString" }
    postcode { "MyString" }
    website { "MyString" }
  end
end
