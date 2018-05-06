class Profile < ApplicationRecord
    validates :luogo_preferito,       presence: true
    validates :stazione_preferita,    presence: true
    validates :carburante_preferito,  presence:true
    validates :litri_serbatoio,       presence:true, numericality: {greater_than: 0}
    validates :targa,                 length: { is: 7 }
end
