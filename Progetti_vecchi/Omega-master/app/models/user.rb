class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_messageable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :properties, dependent: :destroy
  has_many :questions, dependent: :destroy

  has_many :answers, dependent: :destroy

  has_many :reviews, dependent: :destroy

  has_many :ratings
  has_many :answer_rating

  has_and_belongs_to_many :favourites, class_name: "Property", join_table: "favouriters_and_favourites"

  has_and_belongs_to_many(:followings,
    class_name: "User",
    :join_table => "following_connections",
    :foreign_key => "follower_id",
    :association_foreign_key => "following_id")

  validates :username, uniqueness: true, presence: true

  has_attached_file :avatar, styles: { small: "200x200>", medium: "300x300>", thumb: "100x100>" }, default_url: ":style/default_user.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

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
      user.username = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

  def mailboxer_email(object)
    nil
  end

end
