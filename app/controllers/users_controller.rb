class UsersController < ApplicationController
  before_action :require_login, :check_user, :redirect_if_logged_in
  skip_before_action :require_login, :check_user, only: [:new, :create]
  skip_before_action :redirect_if_logged_in, only: [:edit, :update, :show, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to root_path, notice: 'New user was created successfully!'
    else
      redirect_to new_user_path, alert: "#{@user.error_msg}"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params) then
      redirect_to root_path, notice: 'User details were updated successfully!'
    else
      redirect_to edit_user_path(@user), alert: "#{@user.error_msg}"
    end
  end

  def destroy
    if @user.delete then
      log_out
      redirect_to root_path, notice: 'User account was deleted successfully!'
    else
      redirect_to show_user_path(@user), alert: "#{@user.error_msg}"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :google_signup)
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: 'Please login first!'
    end
  end

  def check_user
    @user = User.find_by(id: params[:id])
    redirect_to root_path, alert: 'User does not exist!' if !@user then
    redirect_to root_path, alert: 'You cannot delete this user profile!' if @user != current_user
  end

  def redirect_if_logged_in
    redirect_to root_path, alert: 'You already have an account!'
  end

end
