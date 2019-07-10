class SessionsController < ApplicationController
  before_action :redirect_if_logged_in
  skip_before_action :redirect_if_logged_in, only: [:loggedin_user, :destroy]

  def loggedin_user
    render json: current_user, status: 200
  end

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
        @user = User.new(email: params[:user][:email])
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
