class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      log_in(@user)
      redirect_to root_path
    else
      if @user then
        @user.errors.add(:password, 'is wrong. Authentication failure!')
      else
        @user = User.new(user_params)
        @user.errors.add(:email, 'does not exist. User not found!')
      end
      flash.now.alert = "#{@user.error_msg}"
      render :new
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
      flash.now.alert = 'OAuth login error! Please try again.'
      redirect_to login_path
    end
  end

end
