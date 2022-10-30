class AddExpiryDateToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :expiry_date, :date, nill: false, default: -> { 'NOW()' }
  end
end
