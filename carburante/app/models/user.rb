class User < ApplicationRecord

    #Relazioni
    # un utente puo' avere piu' macchine
    has_many :cars

    #Vincoli

    #Password di almeno 8 caratteri obbligatoria
    validates :password, presence: true, length: {minimum: 8}

    #Email obbligatoria
    validates :email, presence: true

    #has_attached_file :avatar, styles: { small: "200x200>", medium: "300x300>", thumb: "100x100>" }, default_url: ":style/default_user.jpg"

    #validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

    def self.search(term)
        where('LOWER(Indirizzo) LIKE :term OR LOWER(Comune) LIKE :term', term: "%#{term.downcase}%")
    end

end
