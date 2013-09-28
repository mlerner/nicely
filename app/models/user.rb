class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  recommends :tasks
  before_save :default_values

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password,
                  :password_confirmation, :remember_me, :points
  has_many :offers
  has_many :tasks
  has_many :feedback_entries, foreign_key: 'user_id', class_name: 'Comment'

  def default_values
    self.points ||= 0
  end

  def display_name
    if self.name
      self.name
    else
      'Anonymous'
    end
  end
end
