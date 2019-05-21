class DispensersController < ApplicationController
  def index
    @user = User.find_by_id(session[:user_id])
  end

  def new
    @dispenser = Dispenser.new
  end

  def create
    @user = User.find_by_id(session[:user_id])
    @dispenser = Dispenser.new(dispenser_params)
    @dispenser.user = @user
    if @dispenser.save
      redirect_to user_path(@user)
    else
      redirect_to new_dispenser_path
    end
  end

  def edit
    @dispenser = Dispenser.find_by_id(params[:id])
  end

  def update
    @dispenser = Dispenser.find_by_id(params[:id])
    @dispenser.update(:name => params[:dispenser][:name])
    redirect_to dispenser_plants_path(@dispenser)
  end

  def destroy
  end

  private

  def dispenser_params
    params.require(:dispenser).permit(:name, :product_number, :capacity)
  end
end
