class AddPointsToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :start_xy, :geometry, :srid => 4326 
    add_column :tasks, :end_xy, :geometry, :srid => 4326 
  end
end
