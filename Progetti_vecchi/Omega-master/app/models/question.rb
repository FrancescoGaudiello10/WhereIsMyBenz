class Question < ApplicationRecord
  belongs_to :user
  belongs_to :property

  has_many :answers, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates :body, presence: true, length: {minimum: 5}
  validates :valutation, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
end
