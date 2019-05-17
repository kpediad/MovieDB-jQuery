class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :sort_direction, :sort_column

  private

  def sort_column
    if params[:controller] == 'movies' && params[:action] =='index' then
      sortable_columns.include?(params[:column]) ? params[:column] : "title"
    else
      sortable_columns.include?(params[:column]) ? params[:column] : "rating"
    end
  end

  def sortable_columns
    if params[:controller] == 'movies' && params[:action] =='index' then
      ["title", "release_year", "avg_rating"]
    else
      ["name", "rating"]
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def validate_movie
    if params[:movie_id] then
      @movie = Movie.find_by(id: params[:movie_id])
    else
      @movie = Movie.find_by(id: params[:id])
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

end
