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
    if @user = User.find_by_id(params[:id])
      redirect_unless_logged_current
      if @user.dispensers.detect {|disp| disp.plants.empty?}
        flash[:error] = "One or more of your Watering Cans do not have plants assigned to them yet. Please add plants or delete the unused dispenser by visiting My Watering Cans."
        return redirect_to user_path(@user)
      end
      @vaca = params[:watering][:vacation_days]
      @user.dispensers.each do |disp|
        Plant.vacation_start(disp.id, @vaca)
        @container = Container.create(:dispenser_id => disp.id, :date => Date.current, :start_amount => 0)
        @end_day = (Date.current + @vaca.to_i)
        if @watering = Watering.create(:container_id => @container.id, :leftover => 0, :end_vacation => @end_day, :vacation_days => @vaca.to_i, :date => Date.current, :start_vacation => Date.current, :plant_id => disp.plants.first.id)
          flash[:success] = "Vacation time has been successfully updated."
          return redirect_to user_path(@user)
        else
          flash[:error] = "Vacation days must be greater than zero."
          return redirect_to user_path(@user)
        end
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
