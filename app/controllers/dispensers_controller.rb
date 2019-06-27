class DispensersController < ApplicationController
  before_action :require_login

  def index
    @user = current_user
    respond_to do |f|
      f.html
      f.json {render json: @user}
    end
  end

  def new
    @user = current_user
    @dispenser = Dispenser.new
  end

  def create
    @user = current_user
    @dispenser = Dispenser.new(dispenser_params)
    @dispenser.user = @user
    if @dispenser.save
      Container.create(:dispenser_id => @dispenser.id, :date => Date.current, :start_amount => 0)
      flash[:success] = "#{@dispenser.name} has been successfully registered."
      redirect_to dispensers_path(@dispenser)
    else
      error_messages(@dispenser)
      render :new
    end
  end

  def edit
    @user = current_user
    @dispenser = Dispenser.find_by_id(params[:id])
  end

  def update
    @dispenser = Dispenser.find_by_id(params[:id])
    if @dispenser.update(:name => params[:dispenser][:name])
      flash[:success] = "#{@dispenser.name} has been successfully updated."
      respond_to do |f|
        f.html {redirect_to dispenser_plants_path(@dispenser)}
        f.json {render json: @dispenser}
      end
    else
      error_messages(@dispenser)
      return redirect_to edit_dispenser_path(@dispenser)
    end
  end

  def destroy
    @dispenser = Dispenser.find_by_id(params[:id])
    name = @dispenser.name
    @dispenser.destroy
    flash[:success] = "#{name} has been successfully deleted."
    redirect_to dispensers_path
  end


  private

  def dispenser_params
    params.require(:dispenser).permit(:name, :product_number, :capacity)
  end
end
