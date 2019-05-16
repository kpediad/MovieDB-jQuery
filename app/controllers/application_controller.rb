class ApplicationController < ActionController::Base
  layout :determine_layout
  helper_method :current_user, :logged_in?

  private

  def validate_movie
    if params[:movie_id] then
      @movie = Movie.find(params[:movie_id])
    else
      @movie = Movie.find(params[:id])
    end
    if !@movie then
      flash.alert = "Requested movie does not exist!"
      redirect_to movies_path
    end
  end

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

  def require_login
    unless logged_in?
      flash.alert = "Please login first!"
      redirect_to login_path
    end
  end

  def determine_layout
    logged_in? ? 'application' : 'generic'
  end
end
