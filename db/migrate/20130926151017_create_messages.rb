class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.string :content
      t.integer :task_id

      t.timestamps
    end
  end
end
