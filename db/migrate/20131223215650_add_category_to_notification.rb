class AddCategoryToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :category, :integer
  end
end
