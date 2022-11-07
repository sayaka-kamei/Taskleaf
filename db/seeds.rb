# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'admin',
              email: 'admin1@example.com',
              admin: 'true',
              password: 'password',
              password_confirmation: 'password'
              )

10.times do |i|
  User.create!(name: "test#{i+1}",
              email: "test_test#{i+1}@example.com",
              password: 'password',
              password_confirmation: 'password'
              )
end              

10.times do |i|
  Task.create!(user_id: i + 1,
              name: "test_name#{i+1}",
              description: "test_description#{i+1}",
              created_at: "2022/11/07",
              expiry_date: '2022/12/10',
              status: rand(0..2),
              )  
end

10.times do |i|
  Label.create!(name: "sample#{i+1}")
end               