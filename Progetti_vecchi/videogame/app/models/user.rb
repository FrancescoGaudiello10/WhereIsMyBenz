class User < ActiveRecord::Base
    validates :name, :presence => true
    validates :email, :presence => true

    # Include default devise modules. Others available are:
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :omniauthable, :omniauth_providers => [:facebook]

    has_many :games
    has_many :reviews
    has_many :ads
    has_many :responses
    has_many :reports

    def self.search(target)
        if target[:parameter] != ""
            @result = User.where("name LIKE ? OR email LIKE ?", target[:parameter], target[:parameter])
        else
            @result = User.all
        end
        if target[:role] != "Any"
            @result = @result.where("role LIKE ?", target[:role])
        end
        @result
    end

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.name = auth.info.name
            if (user.role != "Banned")
                if (User.where(:role == "Admin").length < 1)
                user.role = "Admin"
                elsif (user.role == nil || user.role == "")
                user.role = "Active"
                end
            end
            user.password = Devise.friendly_token[0,20]
        end
    end

    def self.new_with_session(params, session)
        super.tap do |user|
            if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
                user.email = data["email"] if user.email.blank?
            end
        end
    end

end
