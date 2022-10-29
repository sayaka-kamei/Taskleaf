FactoryBot.define do
  factory :task do
    name { 'test_name1' }
    description { 'test_description1' }
    expiry_date { '2022/11/10' }
  end

  factory :second_task, class: Task do
    name { 'test_name2' }
    description { 'test_description2' }
    expiry_date { '2022/11/12' }
  end
end
