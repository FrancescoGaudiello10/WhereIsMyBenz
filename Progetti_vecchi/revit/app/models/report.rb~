class Report < ActiveRecord::Base
  belongs_to :reporter, class_name: 'User', dependent: :destroy
  belongs_to :reported, class_name: 'Review', dependent: :destroy
  validates :reported_id,presence:true
  validates :reporter_id,presence:true
end
