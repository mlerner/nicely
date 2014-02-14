class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  recommends :tasks
  before_save :default_values

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password,
                  :password_confirmation, :remember_me, :points
  has_many :offers
  has_many :tasks
  has_many :feedback, foreign_key: 'user_id', class_name: 'Comment'
  validates_uniqueness_of :name

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.save!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

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
