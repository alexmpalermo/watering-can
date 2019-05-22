class UsersController < ApplicationController
  def home
  end

  def signup
    @user = User.new
  end

  def create
    return redirect_to new_user_path unless params[:user][:password] == params[:user][:password_confirmation]
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to user_path(@user)
    end
  end

  def show
    if logged_in?
     @user = User.find(params[:id])
     if @user == current_user
       @watering = Watering.new 
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
