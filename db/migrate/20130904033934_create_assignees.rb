class CreateAssignees < ActiveRecord::Migration
  def change
    create_table :assignees do |t|
      t.integer :user_id
      t.integer :task_id

      t.timestamps
    end
  end
end
