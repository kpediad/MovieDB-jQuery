class User < ApplicationRecord
  has_many :reviews
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
      user.google_signup = true
      user.password = SecureRandom.hex
    end
  end

  def error_msg
    if self.errors.any? then
      msg = "#{'Error'.pluralize(self.errors.count)}: "
      self.errors.full_messages.each do |message|
        msg = msg + "#{message} - "
      end
      msg.chop!.chop!.chop!
    else
      msg = 'No errors occured.'
    end
    return msg
  end

end
