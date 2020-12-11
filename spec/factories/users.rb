FactoryBot.define do
  factory :user do
    username { 'user1' }
    email { 'user1@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
  end
  factory :admin_user, class: User do
    username { 'admin_user' }
    email { 'admin@example.com' }
    password { '12345678' }
    password_confirmation { '12345678' }
    admin { true }
  end
end
