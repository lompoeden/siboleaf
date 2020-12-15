FactoryBot.define do
  factory :user do
    username { "Lompo" }
    email { "lompo@gmail.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
