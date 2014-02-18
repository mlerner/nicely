class AddPointsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :points, :bigint
  end
end
