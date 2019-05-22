class UsersController < ApplicationController
  def home
    logged_in_or_redirect
  end

  def signup
    logged_in_or_redirect
    @user = User.new
  end

  def create
    logged_in_or_redirect
    return redirect_to new_user_path unless params[:user][:password] == params[:user][:password_confirmation]
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to user_path(@user) 
    end
  end

  def show
    if @user = User.find_by_id(params[:id])
      @watering = Watering.new
      redirect_to home_path unless logged_in? && @user == current_user
    else
     redirect_to home_path
    end
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
