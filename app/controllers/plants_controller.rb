class PlantsController < ApplicationController
  def index
    @dispenser = Dispenser.find_by_id(params[:dispenser_id])
  end

  def new
    @plant = Plant.new
  end

  def create
  end

  def edit
    @plant = Plant.find_by(:dispenser_id => params[:dispenser_id])
  end

  def update
  end

  def destroy
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :location, :water_quantity, :water_frequency)
  end
end
