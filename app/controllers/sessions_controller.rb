class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      log_in(user)
      redirect_to root_path
    else
      user ? {alert: 'Authentication error!'} : {alert: 'User does not exist!'}
      redirect_to login_path
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  def googleAuth
    # Get access tokens from the google server
    access_token = request.env["omniauth.auth"]
    user = User.from_omniauth(access_token)
    if user.save then
      log_in(user)
      redirect_to root_path
    else
      redirect_to login_path, alert: 'OAuth login error! Please try again.'
    end
  end

end
