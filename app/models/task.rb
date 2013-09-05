class Task < ActiveRecord::Base
  self.rgeo_factory_generator = RGeo::Geos.factory_generator(srid: 4326)

  attr_accessible :description, :status, :title
  belongs_to :user
  has_one :assignee
  has_many :comments
end
