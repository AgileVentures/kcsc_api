FactoryBot.define do
  factory :user do
    email { "random_guy@email.com" }
    password { "password" }
    name { "John Doe" }
  end
end
