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
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to user_path(@user)
    else
      error_messages(@user)
      render :signup
    end
  end

  def show
    if @user = User.find_by_id(params[:id])
      @watering = Watering.new
      redirect_unless_logged_current
    else
      flash[:error] = "You must be signed up and logged in to access this section."
      redirect_to home_path
    end
  end

  def update
    if @user = User.find_by_id(params[:id])
      redirect_unless_logged_current
      dispenser_plants_vaca_check(@user)
      @vaca = params[:watering][:vacation_days]
      @user.update_vacation_and_plants(@vaca)
      flash[:notice] = "Vacation time has been successfully updated."
      return redirect_to user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
