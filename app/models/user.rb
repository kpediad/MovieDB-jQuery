class User < ApplicationRecord
  has_many :reviews
  has_many :movies, through: :reviews

  has_secure_password

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
      msg = 'The following error(s) occured:\n'
      self.errors.full_messages.each_with_index do |i, message|
        msg = msg + "#{i. message}\n"
      end
    else
      msg = 'No errors occured.'
    end
    return msg
  end

end
