class UsersController < ApplicationController
  def home
  end

  def signup
  end

  def create
    return redirect_to new_user_path unless params[:user][:password] == params[:user][:password_confirmation]
    @user = User.create(user_params)
    log_in(@user)
    redirect_to user_path(@user)
  end

  def show
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
