class Task < ActiveRecord::Base
  self.rgeo_factory_generator = RGeo::Geos.factory_generator(srid: 4326)
  RGeo::ActiveRecord::GeometryMixin.set_json_generator(:geojson)
  attr_accessible :description, :status, :title,
                  :start_time, :start_loc, :end_loc,
                  :estimated_time, :start_xy, :end_xy
  validates_presence_of :description, :title, :estimated_time, :start_loc
  before_save :default_values
  belongs_to :user
  has_one :assignee
  has_many :comments
  has_many :offers
  has_many :reports

  def default_values
    self.status = 0
    self.start_loc ||= 'None'
    self.end_loc ||= 'None'
  end

end
