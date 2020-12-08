FactoryBot.define do
  factory :user do
    email { "MyString"}
    username { "MyString" }
    password_digest { "MyString" }
    type { "" }
  end
end
