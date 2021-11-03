class User < ApplicationRecord
  attr_accessor :remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  before_save :downcase_email

  validates :name,  presence: true, length: {maximum: Settings.char_50}
  validates :email, presence: true,
                    length: {maximum: Settings.char_255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: true
  validates :password, presence: true, length: {minimum: Settings.char_6}

  has_secure_password

  # Returns the hash digest of the given string.
  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_column(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated? remember_token
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_column(:remember_digest, nil)
  end

  private
  def downcase_email
    email.downcase!
  end
end
