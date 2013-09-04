class Assignee < ActiveRecord::Base
  belongs_to :task
  has_one :user
end
