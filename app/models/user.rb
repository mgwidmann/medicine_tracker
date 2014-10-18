class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation

  validates_presence_of :email
  validates_uniqueness_of :email

  # Don't like using validates_confirmation_of as it has some problems
  validates_presence_of :password, if: ->{ password_confirmation.present? || new_record? }
  validates_presence_of :password_confirmation, if: ->{ password.present? || new_record? }
  validate :passwords_match, if: ->{ password.present? || new_record? }

  validates_presence_of :password_hash, :password_salt, on: :update

  before_save :encrypt_password

  def self.login(email, password)
    user = find_by(email: email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def passwords_match
    unless password == password_confirmation
      errors.add(:password, "does not match")
    end
  end
end
