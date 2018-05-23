class Station < ApplicationRecord

    has_many :comments, as: :commentable, dependent: :destroy

    validates :Bandiera, presence: true
    validates :Nome, presence: true
    validates :Indirizzo, presence: true
    validates :Benzina, numericality: {greater_than: 0, allow_nil: true}
    validates :Diesel, numericality: {greater_than: 0, allow_nil: true}
    validates :Super, numericality: {greater_than: 0, allow_nil: true}
    validates :Excellium, numericality: {greater_than: 0, allow_nil: true}
    validates :Metano, numericality: {greater_than: 0, allow_nil: true}
    validates :GPL, numericality: {greater_than: 0, allow_nil: true}

end
