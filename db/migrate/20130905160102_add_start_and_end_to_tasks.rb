class AddStartAndEndToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :start_loc, :string
    add_column :tasks, :end_loc, :string
  end
end
