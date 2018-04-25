class Station < ApplicationRecord
    # If you delete an article, its associated comments will also need to be deleted, otherwise they would simply occupy space in the database
    has_many :reviews, dependent: :destroy
    validates :Bandiera, presence: true
end
