class ApplicationController < ActionController::Base
  layout :determine_layout
  helper_method :current_user

  private

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete :user_id
  end

  def determine_layout
    logged_in? ? 'application' : 'generic'
  end
end
