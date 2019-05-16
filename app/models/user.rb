class User < ApplicationRecord
  has_many :reviews, dependent: :delete_all
  has_many :movies, through: :reviews

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i }
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true

  def self.from_omniauth(auth)
    # Creates a new user only if it doesn't exist
    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = SecureRandom.hex
      user.password_confirmation = user.password
      user.save
    end
  end

end
