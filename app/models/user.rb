class User < ApplicationRecord
  attr_reader :password

  validates :username, :session_token, presence: true, uniqueness: true  
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :password_digest, presence: true
  after_initialize :ensure_session_token

  has_many :goals,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Goal,
    dependent: :destroy

  has_many :comments,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :UserComment,
    dependent: :destroy

  def self.generate_unique_session_token
    token = SecureRandom.urlsafe_base64(16)

    while User.exists?(session_token: token)
      token = SecureRandom.urlsafe_base64(16)
    end

    token
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    
    if user && user.is_password?(password)
      return user
    end

    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    digest = BCrypt::Password.new(self.password_digest)
    digest.is_password?(password) 
  end

  def reset_session_token!
    self.session_token = User.generate_unique_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_unique_session_token
  end
end
