FactoryBot.define do
  factory :section do
    view 
    header { "MyString" }
    description { "MyText" }
    factory :regular do
      variant { :regular }
    end

    factory :slider do
      variant { :slider }
    end

    factory :no_image do
      variant { :no_image }
    end

    factory :carousel do
      variant { :carousel }
    end
  end
end


# regular: 0, no_image: 1, carousel: 2, slider: 3
