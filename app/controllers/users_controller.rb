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
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:error] = "Password must match Password Confirmation."
      return redirect_to new_user_path
    end
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to user_path(@user)
    else
      flash[:error] = "All fields must be filled in. Email cannot be one that is already used"
      return redirect_to new_user_path
    end
  end

  def show
    if @user = User.find_by_id(params[:id])
      @watering = Watering.new
      redirect_unless_logged_current
    else
      flash[:error] = "You must be logged in to access this section"
      redirect_to home_path
    end
  end

  def update
  flash[:error] = "Vacation Days must be greater than 0."
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
