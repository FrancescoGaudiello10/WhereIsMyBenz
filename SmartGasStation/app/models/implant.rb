class Implant < ApplicationRecord

    #Database relations
    #has_many :comments, as: :commentable, dependent: :destroy
    has_many :prices

    #REST requests
    require 'httparty'

    #Location https://www.youtube.com/watch?v=4iAjdTrgAvs
    geocoded_by :full_address #, :latitude  => :Latitudine, :longitude => :Longitudine
    after_validation :geocode, if: :address_changed?

    private
    def full_address
        [:Indirizzo, :Comune, :Provincia].compact.join(',')
    end


end
