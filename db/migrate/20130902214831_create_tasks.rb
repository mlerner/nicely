class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :status
      t.string :description
      t.point :start_xy, :geographic => true
      t.point :end_xy, :geographic => true

      t.timestamps
    end
  end
end
