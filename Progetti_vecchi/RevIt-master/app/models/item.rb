class Item < ActiveRecord::Base
  belongs_to :user
  has_many :reviews, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :tag_list, presence: true
  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: 100}
  validates :user, presence:true
  validate  :picture_size
  validates :description, presence: true

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :categories


def self.search(search_name, search_rating, min_price, max_price) 
  return Item.all unless search_name.present? || search_rating.present? || min_price.present? || max_price.present?
   float_rate=search_rating.to_f 
   float_min_price=min_price.to_f 
  float_max_price=max_price.to_f 
  where(['name LIKE ? AND avg_rating >= ? AND avg_price >= ? AND avg_price <= ?', "%#{search_name}%", float_rate, float_min_price, float_max_price]) 
end

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
