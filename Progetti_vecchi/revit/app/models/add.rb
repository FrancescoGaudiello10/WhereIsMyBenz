class Add < ActiveRecord::Base
  belongs_to :owner
  validates :owner_id, presence: true
  validates :price , presence: true
  validates :name , presence: true , length: {maximum: 50}
  validates :description, presence: true
  validates_numericality_of :price, greater_than_or_equal_to: 0
  mount_uploader :picture, PictureUploader

  default_scope -> { order(created_at: :desc) }
  

  validate  :picture_size

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end
