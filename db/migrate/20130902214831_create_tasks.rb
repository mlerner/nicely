class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :status
      t.string :description

      t.timestamps
    end
  end
end
