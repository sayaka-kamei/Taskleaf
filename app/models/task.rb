class Task < ApplicationRecord
  validates :name, :description, :expiry_date, :status, presence: true
  scope :search_name, -> (name){where('name LIKE ?',"%#{name}%")}
  scope :search_status, -> (status){where(status: status)}
  scope :search_name_status, -> (name,status){where('name LIKE ?',"%#{name}%").where(status: status)}
end
