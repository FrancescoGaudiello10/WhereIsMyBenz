class User < ActiveRecord::Base
  acts_as_voter
  #RECEIVER DEI FEEDBACKS
  has_many :passive_feedbacks, class_name: "Feedback",
  				foreign_key: "receiver_id",
				dependent: :destroy
  has_many :givers, through: :passive_feedbacks, source: :giver
  #GIVER DEI FEEDBACKS
  has_many :active_feedbacks, class_name: "Feedback",
  				foreign_key: "giver_id",
  				dependent: :destroy
  has_many :feedbacks, through: :active_feedbacks, source: :receiver
  #GIVER DELLE VALUTAZIONI
  has_many :active_evaluations, class_name: "Evaluation",
  				foreign_key: "evaluater_id",
  				dependent: :destroy
  has_many :evaluations, through: :active_evaluations, source: :evaluated
  #REPORTER
  has_many :active_reports, class_name: "Report",
  				foreign_key: "reporter_id",
  				dependent: :destroy
  has_many :reports, through: :active_reports, source: :reported
  #end#Reporter
  has_many :reviews, dependent: :destroy
  has_many :authorizations
  has_many :items, dependent: :destroy
  attr_accessor :remember_token , :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest

  

  validates :name, presence: true, length: {maximum: 100}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  def feed
    Item.where("user_id = ?", id)
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
    
    def self.search(search_user)
      where("name LIKE ?", "%#{search_user}%")
  
    end
  
end
