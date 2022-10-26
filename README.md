# README

- create_table "users"
  - name string
  - email string
  - password string

- create_table "tasks"
  - name string
  - description text
  - user references

- create_table "labels"
  - label string

- herokuへのデプロイ方法
  - heroku login
  - heroku create
  - gemファイルにgem 'net-smtp'gem 'net-imap' gem 'net-pop'を追加
  - bundle install
  - heroku buildpacks:set heroku/ruby
  - heroku buildpacks:add --index 1 heroku/nodejs
  - heroku stack:set heroku-20
  - bundle lock --add-platform x86_64-linux
  - bundle install
  - git add .
  - git push heroku step2:master