FactoryBot.define do
  factory :task do
    name { 'test_name1' }
    description { 'test_description1' }
    expiry_date { '2022/11/10' }
    status { '着手' }
  end

  factory :second_task, class: Task do
    name { 'test_name2' }
    description { 'test_description2' }
    expiry_date { '2022/11/30' }
    status { '未着手' }
  end

  factory :third_task, class: Task do
    name { 'test_name3' }
    description { 'test_description3' }
    expiry_date { '2022/11/20' }
    status { '完了' }
  end
end
