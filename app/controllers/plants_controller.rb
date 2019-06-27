class PlantsController < ApplicationController
  before_action :require_login

  def index
    if @dispenser = Dispenser.find_by_id(params[:dispenser_id])
      @user = User.find_by_id(@dispenser.user_id)
      redirect_unless_logged_current
      respond_to do |f|
        f.html
        f.json {render json: @dispenser}
      end
    else
      redirect_to home_path
    end
  end

  def show
    if @dispenser = Dispenser.find_by_id(params[:dispenser_id])
      @user = User.find_by_id(@dispenser.user_id)
      @plant = Plant.find_by_id(params[:id])
      redirect_unless_logged_current
      respond_to do |f|
        f.html
        f.json {render json: @dispenser}
      end
    else
      redirect_to home_path
    end
  end


  def new
    @user = current_user
    @plant = Plant.new
    @dispenser = Dispenser.find_by_id(params[:dispenser_id])
  end

  def create
    @user = current_user
    @dispenser = Dispenser.find_by_id(params[:dispenser_id])
    @plant = Plant.new(plant_params)
    @plant.last_day_watered = Date.current
    @plant.next_water_day = (Date.current + @plant.water_frequency)
    @plant.needs_water = false
    @plant.dispenser = @dispenser
    if @plant.save
      Watering.create(:plant_id => @plant.id, :container_id => @dispenser.containers.last.id, :vacation_days => 0, :start_vacation => (Date.current - 1), :end_vacation => (Date.current - 1), :date => Date.current, :leftover => 0)
      flash[:success] = "#{@plant.name} has been successfully created."
      redirect_to dispenser_plants_path(@dispenser)
    else
      error_messages(@plant)
      render :new
    end
  end

  def edit
    @user = current_user
    @dispenser = Dispenser.find_by_id(params[:dispenser_id])
    @plant = Plant.find_by_id(params[:id])
  end

  def update
    @dispenser = Dispenser.find_by_id(params[:dispenser_id])
    @plant = Plant.find_by_id(params[:id])
    if @plant.update(:name => params[:plant][:name], :location => params[:plant][:location], :water_quantity => params[:plant][:water_quantity], :water_frequency => params[:plant][:water_frequency])
      flash[:success] = "#{@plant.name} has been successfully updated."
      redirect_to dispenser_plants_path(@dispenser)
    else
      error_messages(@plant)
      return redirect_to edit_dispenser_plant_path(@dispenser, @plant)
    end
  end

  def destroy
    @dispenser = Dispenser.find_by_id(params[:dispenser_id])
    @plant = Plant.find_by_id(params[:id])
    name = @plant.name
    @plant.destroy
    flash[:success] = "#{name} has been successfully deleted."
    redirect_to dispenser_plants_path(@dispenser)
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :location, :water_quantity, :water_frequency)
  end
end
