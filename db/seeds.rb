# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'admin',
              email: 'admin100@example.com',
              admin: 'true',
              password: 'password',
              password_confirmation: 'password',
              )

Task.create!(name: 'test_name1',
              description: 'test_description1',
              expiry_date: '2022/11/10',
              status: '着手',
              priority: '高',
              user_id: '1'
              )              
