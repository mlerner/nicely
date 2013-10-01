class Task < ActiveRecord::Base
  TASK_PER_PAGE = 10
  ACTIVE_TASK = 0
  self.table_name = 'tasks'
  self.rgeo_factory_generator = RGeo::Geos.factory_generator(srid: 4326)
  RGeo::ActiveRecord::GeometryMixin.set_json_generator(:geojson)
  attr_accessible :description, :status, :title,
                  :start_time, :start_loc, :end_loc,
                  :estimated_time, :start_xy, :end_xy
  validates_presence_of :description, :title, :estimated_time, :start_loc
  before_save :default_values
  belongs_to :user
  has_one :assignee, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :reports, dependent: :destroy

  scope :close_to, ->(latitude, longitude, distance_in_meters = 10000) {
    where(%{
      ST_DWithin(
        ST_Transform(tasks.start_xy, 4326),
        ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
        %d
      )
      } % [longitude, latitude, distance_in_meters]
    )
  }

  scope :active, -> {
    where(%{
        tasks.status = 0
      }
    )
  }

  def default_values
    self.status ||= 0
    self.start_loc ||= 'None'
    self.end_loc ||= 'None'
  end

  def is_owner?(user)
    self.user.id == user.id
  end

  def active?
    self.status == ACTIVE_TASK
  end

end
