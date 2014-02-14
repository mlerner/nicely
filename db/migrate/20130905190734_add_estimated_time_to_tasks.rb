class AddEstimatedTimeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :estimated_time, :integer
  end
end
