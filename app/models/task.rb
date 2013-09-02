class Task < ActiveRecord::Base
  attr_accessible :description, :status, :title
  belongs_to :user
  has_one :requester
  has_many :comments
  has_many :reports
end
