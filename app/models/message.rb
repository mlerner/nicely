class Message < ActiveRecord::Base
  attr_accessible :content, :sender_id
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'User'
  belongs_to :task
  accepts_nested_attributes_for :task, :sender
end
