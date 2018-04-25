class Price < ApplicationRecord
    belongs_to :implant, optional: true
end
