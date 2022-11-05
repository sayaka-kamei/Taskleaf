FactoryBot.define do
  factory :user, class: User  do
    id { 1 }
    name { 'name1' }
    email { 'email1@gmail.com' }
    password { 'password1' }
    password_confirmation { 'password1' }
    admin { true }
  end
  factory :second_user, class: User do
    id { 2 }
    name { 'name2' }
    email { 'email2@gmail.com' }
    password { 'password2' }
    password_confirmation { 'password2' }
    admin { false }
  end
end

