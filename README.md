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