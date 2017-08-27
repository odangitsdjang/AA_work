class User < ApplicationRecord
  attr_reader :password

  after_initialize :ensure_session_token
  validates :password, length: {minimum: 6}, allow_nil: true
  validates :email, :session_token, presence: true

  def self.find_by_credentials(email, pw)
    u = User.find_by(email: email)
    return u if u && BCrypt::Password.new(u.password_digest).is_password?(pw)
    nil
  end

  def self.generate_session_token
    SecureRandom.base64(16)
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end


  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
