class AddDataToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :user_id, :integer
    add_column :offers, :task_id, :integer
  end
end
