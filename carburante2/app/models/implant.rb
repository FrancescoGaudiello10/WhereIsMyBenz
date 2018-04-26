class Implant < ApplicationRecord

    #REST requests
    require 'httparty'

    #Database relations
    has_many :prices

    #Location https://www.youtube.com/watch?v=4iAjdTrgAvs
    geocoded_by :full_address, :latitude  => :latitude, :longitude => :longitude
    after_validation :geocode#, if: :address_changed?

    private
    def full_address
        [:Indirizzo, :Comune, :Provincia].compact.join(',')
    end

end
