class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      log_in(@user)
      redirect_to root_path
    else
      if @user then
        params[:user][:password].empty? ? error = "can't be blank!" : error = "is wrong. Authentication failure!"
        @user.errors.add(:password, error)
      else
        @user = User.new(user_params)
        params[:user][:email].empty? ? error = "can't be blank!" : error = "does not exist. User not found!"
        @user.errors.add(:email, error)
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
    access_token = request.env["omniauth.auth"]
    user = User.from_omniauth(access_token)
    log_in(user)
    redirect_to root_path
  end

end
