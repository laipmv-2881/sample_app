class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  before_save :downcase_email

  validates :name,  presence: true, length: {maximum: Settings.char_50}
  validates :email, presence: true,
                    length: {maximum: Settings.char_255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: true
  validates :password, presence: true, length: {minimum: Settings.char_6}

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
