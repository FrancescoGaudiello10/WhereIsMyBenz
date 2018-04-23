class Car < ActiveRecord::Base

    #Relazioni
    # una macchina appartiene ad 1 solo utente
    belongs_to :user

    #Vincoli
    validates :capacita_serbatoio, presence: true
    validates :tipo_carburante, presence: true
end
