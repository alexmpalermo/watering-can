class DispensersController < ApplicationController
  before_action :require_login

  def index
    @user = current_user
  end

  def new
    @dispenser = Dispenser.new
  end

  def create
    @user = current_user
    @dispenser = Dispenser.new(dispenser_params)
    @dispenser.user = @user
    if @dispenser.save
      flash[:success] = "#{@dispenser.name} has been successfully registered."
      redirect_to user_path(@user)
    else
      flash[:error] = "All fields must be filled in. Product number must be one that hasn't been registered before."
      redirect_to new_dispenser_path
    end
  end

  def edit
    @dispenser = Dispenser.find_by_id(params[:id])
  end

  def update
    @dispenser = Dispenser.find_by_id(params[:id])
    @dispenser.update(:name => params[:dispenser][:name])
    flash[:success] = "#{@dispenser.name} has been successfully updated."
    redirect_to dispenser_plants_path(@dispenser)
  end

  def destroy
    @dispenser = Dispenser.find_by_id(params[:id])
    name = @dispenser.name
    @dispenser.destroy
    flash[:notice] = "#{name} has been successfully deleted."
    redirect_to dispensers_path
  end


  private

  def dispenser_params
    params.require(:dispenser).permit(:name, :product_number, :capacity)
  end
end
