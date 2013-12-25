class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :sender_id
      t.integer :parent_id
      t.string :parent_type
      t.date :expiration_date
      t.string :notification

      t.timestamps
    end
  end
end
