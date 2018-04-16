class Property < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 50}
  validates :description, presence:true, length: { minimum: 10}
  validates :price, presence:true, numericality: {greater_than: 0}
  validates :city, presence: true

  belongs_to :user
  has_and_belongs_to_many :favouriters, class_name: "User", join_table: "favouriters_and_favourites"
  paginates_per 3

  serialize :categories, Array

  has_attached_file :img1, styles: { small: "200x200>", medium: "300x300>", thumb: "100x100>" }, default_url: ":style/default_local.jpg"
  validates_attachment_content_type :img1, content_type: /\Aimage\/.*\z/

  has_attached_file :img2, styles: { small: "200x200>", medium: "300x300>", thumb: "100x100>" }, default_url: ":style/default_local.jpg"
  validates_attachment_content_type :img2, content_type: /\Aimage\/.*\z/

  has_attached_file :img3, styles: { small: "200x200>", medium: "300x300>", thumb: "100x100>" }, default_url: ":style/default_local.jpg"
  validates_attachment_content_type :img3, content_type: /\Aimage\/.*\z/

  has_many :questions, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :prenotations, dependent: :destroy

  geocoded_by :city
  after_validation :geocode
end
