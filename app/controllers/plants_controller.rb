class PlantsController < ApplicationController
  def index
    if @dispenser = Dispenser.find_by_id(params[:dispenser_id])
      @user = User.find_by_id(@dispenser.user_id)
      redirect_to home_path unless logged_in? && @user = current_user
    else
      redirect_to home_path
    end 
  end

  def new
    @plant = Plant.new
    @dispenser = Dispenser.find_by_id(params[:dispenser_id])
  end

  def create
    @dispenser = Dispenser.find_by_id(params[:dispenser_id])
    @plant = Plant.new(plant_params)
    @plant.dispenser = @dispenser
    if @plant.save
      redirect_to dispenser_plants_path(@dispenser)
    else
      redirect_to new_dispenser_plant_path(@dispenser)
    end
  end

  def edit
    @dispenser = Dispenser.find_by_id(params[:dispenser_id])
    @plant = Plant.find_by_id(params[:id])
  end

  def update
    @dispenser = Dispenser.find_by_id(params[:dispenser_id])
    @plant = Plant.find_by_id(params[:id])
    @plant.update(:name => params[:plant][:name], :location => params[:plant][:location], :water_quantity => params[:plant][:water_quantity], :water_frequency => params[:plant][:water_frequency])
    redirect_to dispenser_plants_path(@dispenser)
  end

  def destroy
    @dispenser = Dispenser.find_by_id(params[:dispenser_id])
    @plant = Plant.find_by_id(params[:id])
    @plant.destroy
    redirect_to dispenser_plants_path(@dispenser)
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :location, :water_quantity, :water_frequency)
  end
end
