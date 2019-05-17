class UsersController < ApplicationController
  before_action :require_login, :check_user, :redirect_if_logged_in
  skip_before_action :require_login, :check_user, only: [:new, :create]
  skip_before_action :redirect_if_logged_in, only: [:edit, :update, :show, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save then
      log_in(@user)
      flash.notice = "New user was created successfully!"
      redirect_to root_path
    else
      flash.now.alert = "#{@user.error_msg}"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params) then
      flash.notice = "User details were updated successfully!"
      redirect_to root_path
    else
      flash.now.alert = "#{@user.error_msg}"
      render :edit
    end
  end

  def destroy
    if @user.destroy then #reviews that belong to this user should be deleted as well
      log_out
      flash.notice = "User account was deleted successfully!"
      redirect_to root_path
    else
      flash.alert = "#{@user.error_msg}"
      redirect_to show_user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def check_user
    @user = User.find_by(id: params[:id])
    if !@user then
      flash.alert = "User does not exist!"
      redirect_to root_path and return
    end
    if @user != current_user then
      flash.alert = "User profile mismatch!"
      redirect_to root_path and return
    end
  end

  def redirect_if_logged_in
    if logged_in? then
      flash.alert = "You already have an account!"
      redirect_to root_path and return
    end
  end

end
