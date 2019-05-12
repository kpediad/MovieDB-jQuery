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
      redirect_to new_user_path, alert: "#{@user.error_msg}"
    end
  end

  def edit
    if !logged_in? then
      redirect_to login_path, alert: 'Please login first!'
      return
    end
    @user = User.find_by(id: params[:id])
    if !@user then
      redirect_to root_path, alert: 'User does not exist!'
      return
    end
    if @user != current_user then
      redirect_to root_path, alert: 'You cannot edit this user profile!'
      return
    end
  end

  def update
    if !logged_in? then
      redirect_to login_path, alert: 'Please login first!'
      return
    end
    @user = User.find_by(id: params[:id])
    if !@user then
      redirect_to root_path, alert: 'User does not exist!'
      return
    end
    if @user != current_user then
      redirect_to root_path, alert: 'You cannot edit this user profile!'
      return
    end
    if @user.update(user_params)
      redirect_to root_path, notice: 'User details were updated successfully!'
    else
      redirect_to edit_user_path(@user), alert: "#{@user.error_msg}"
    end
  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :google_signup)
  end

end
