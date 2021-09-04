FactoryBot.define do
  factory :section do
    view 
    header { "MyString" }
    description { "MyText" }
    variant { :regular }
  end
end
