class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'User'
  belongs_to :parent, foreign_key: 'parent_id', class_name: 'Task'
  attr_accessible :notification, :expiration_date, :read_date, :category

end
