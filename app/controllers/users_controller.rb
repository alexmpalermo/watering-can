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
      @dispenser = Dispenser.new 
      redirect_unless_logged_current
    else
      flash[:error] = "You must be signed up and logged in to access this section."
      redirect_to home_path
    end
  end

  def update
    if @user = User.find_by_id(params[:id])
      redirect_unless_logged_current
      if @user.dispensers.empty?
        flash[:error] = "You must register at least one Watering Can."
        return redirect_to user_path(@user)
      elsif @user.dispensers.detect {|disp| disp.plants.empty?}
        flash[:error] = "One or more of your Watering Cans do not have plants assigned to them yet. Please add plants or delete the unused dispenser by visiting My Watering Cans."
        return redirect_to user_path(@user)
      end
      @vaca = params[:dispenser][:vacation_days]
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
