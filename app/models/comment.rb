class Comment < ActiveRecord::Base
  attr_accessible :text
  belongs_to :user
  has_one :commenter, foreign_key: 'commenter_id', class_name: 'User'
end
