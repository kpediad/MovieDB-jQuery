class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to root_path
    else
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
    redirect_to root_path, alert: 'User does not exist!' if !@user
    redirect_to root_path, alert: 'You cannot edit this user profile!' if @user != current_user
    redirect_to login_path, alert: 'Please login first!' if !logged_in?  
  end

  def update

  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :google_signup)
  end
end
