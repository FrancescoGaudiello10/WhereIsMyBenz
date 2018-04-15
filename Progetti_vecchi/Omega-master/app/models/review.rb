class Review < ApplicationRecord
  belongs_to :property
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :valutation, presence: true, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 5}
end
