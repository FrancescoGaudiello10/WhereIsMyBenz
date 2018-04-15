class Review < ActiveRecord::Base
  acts_as_votable
  belongs_to :item
  belongs_to :user
  #Report#
  has_many :passive_reports, class_name: "Report",
  				foreign_key: "reported_id",
				dependent: :destroy
  has_many :reporters, through: :passive_reports, source: :reporter
  #end#Report#
  geocoded_by :store_location
  after_validation :geocode, :if => :store_location_changed?
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :comment, presence: true, length: {maximum: 200}
  validates :price, presence: true
  validates :rating, presence: true
  validates :store, presence: true
  validates :item_id, presence: true
  validates :store_location, presence: true
  validates :item_id, presence: true
  validates_numericality_of :rating, greater_than_or_equal_to: 0, less_than_or_equal_to: 5
  validates_numericality_of :price, greater_than_or_equal_to: 0
end
