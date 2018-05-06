class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook]

    validates :luogo_preferito,       presence: true
    validates :stazione_preferita,    presence: true
    validates :carburante_preferito,  presence:true
    validates :litri_serbatoio,       presence:true, numericality: {greater_than: 0}
    validates :targa,                 length: { is: 7 }
    
    # a ciascun utente e' associato un array con gli id degli impianti visitati
    # converto valore nel DB in array
    serialize :idImpianto, Array

    def self.new_with_session(params, session)
        super.tap do |user|
            if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
                user.email = data["email"] if user.email.blank?
            end
        end
    end

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.password = Devise.friendly_token[0,20]
            # user.username = auth.info.name   # assuming the user model has a name
            # user.image = auth.info.image # assuming the user model has an image
        end
    end      

end
