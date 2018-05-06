class Comment < ApplicationRecord
  belongs_to :station
  
  validates :commenter, presence: true
  validates :body, presence: true
  #validates :stars, presence: true, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 5}
  
end