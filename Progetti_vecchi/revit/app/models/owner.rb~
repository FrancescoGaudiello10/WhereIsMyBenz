class Owner < ActiveRecord::Base
  #Valutazione
  has_many :passive_evaluations, class_name: "Evaluation",
  				foreign_key: "evaluated_id",
				dependent: :destroy
  has_many :evaluaters, through: :passive_evaluations, source: :evaluater
  #

  has_many :adds , dependent: :destroy
  attr_accessor :remember_token, :activation_token, :reset_token
  require 'geocoder'
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  before_save   :downcase_email
  before_create :create_activation_digest

  

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  # Returns the hash digest of the given string.
  def Owner.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def Owner.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a owner in the database for use in persistent sessions.
  def remember
    self.remember_token = Owner.new_token
    update_attribute(:remember_digest, Owner.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a owner.
  def forget
    update_attribute(:remember_digest, nil)
  end

   # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def feed
    Add.where("owner_id = ?", id)
  end
  def self.search(search_owner)
      where("name LIKE ?", "%#{search_owner}%")
  
  end
  
  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
