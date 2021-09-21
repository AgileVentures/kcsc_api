FactoryBot.define do
  factory :image do
    alt_text { "MyString" }
    factory :associated_image do
      association :article
    end
    factory :card_logo do
      association :card
    end
    after(:create) do |object|
      file = File.open(Rails.root.join('spec', 'fixtures', 'files', 'placeholder.jpeg'))
      object.file.attach(io: file, filename: 'placeholder.jpeg', content_type: 'image/jpg')
    end
  end
end
