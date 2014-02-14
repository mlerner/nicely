class AddReadDateToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :read_date, :datetime
  end
end
