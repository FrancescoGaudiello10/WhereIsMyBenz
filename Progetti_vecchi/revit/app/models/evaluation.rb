class Evaluation < ActiveRecord::Base
  belongs_to :evaluater, class_name: 'User', dependent: :destroy
  belongs_to :evaluated, class_name: 'Owner', dependent: :destroy
  validates :evaluater_id, presence: true
  validates :evaluated_id, presence: true
  validates :value, presence: true
  validates_numericality_of :value, greater_than_or_equal_to: 0, less_than_or_equal_to: 10
end
