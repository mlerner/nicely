class Task < ActiveRecord::Base
  attr_accessible :description, :status, :title
  belongs_to :user
  has_one :assignee
  has_many :comments
end
