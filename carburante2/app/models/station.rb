class Station < ApplicationRecord
    # If you delete an article, its associated comments will also need to be deleted, otherwise they would simply occupy space in the database
    has_many :comments, dependent: :destroy
    
    validates :Bandiera, presence: true
    validates :Nome, presence: true
    validates :Indirizzo, presence: true
    
    validates :Benzina,   numericality: {greater_than: 0, allow_nil: true}
    validates :Diesel,    numericality: {greater_than: 0, allow_nil: true}
    validates :Super,     numericality: {greater_than: 0, allow_nil: true}
    validates :Excellium, numericality: {greater_than: 0, allow_nil: true}
    validates :Metano,    numericality: {greater_than: 0, allow_nil: true}
    validates :GPL,       numericality: {greater_than: 0, allow_nil: true}
    
end
