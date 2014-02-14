class AddPointIndexToTasks < ActiveRecord::Migration
    def up
      change_table :tasks do |t|
        t.index :start_xy, :spatial => true
      end
    end

    def down
      change_table :tasks do |t|
        t.remove_index :start_xy
      end
    end
end
