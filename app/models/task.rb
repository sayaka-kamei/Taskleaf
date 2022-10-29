class Task < ApplicationRecord
  validates :name, :description, :expiry_date, :status, presence: true
end
