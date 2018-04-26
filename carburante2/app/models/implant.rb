class Implant < ApplicationRecord
    require 'httparty'
    has_many :prices
end
