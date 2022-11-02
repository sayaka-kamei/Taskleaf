FactoryBot.define do
  factory :user do
    name { 'name1' }
    email { 'email1@gmail.com' }
    admin { 'false'}
    password { 'password1' }
  end
  factory :user do
    name { 'name2' }
    email { 'email2@gmail.com' }
    admin { 'true'}
    password { 'password2' }
  end
end

