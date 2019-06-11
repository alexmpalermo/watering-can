module UsersHelper

  def dispenser_plants_vaca_check(user)
    if user.dispensers.empty?
      flash[:error] = "You must register at least one Watering Can."
      return redirect_to user_path(user)
    elsif user.dispensers.detect {|disp| disp.plants.empty?}
      flash[:error] = "One or more of your Watering Cans do not have plants assigned to them yet. Please add plants or delete the unused dispenser by visiting My Watering Cans."
      return redirect_to user_path(user)
    end
  end

  def update_vacation_and_plants(user, vaca)
    user.dispensers.each do |disp|
      Plant.vacation_start(disp, vaca)
      @container = Container.create(:dispenser_id => disp.id, :date => Date.current, :start_amount => 0)
      @end_day = (Date.current + vaca.to_i)
      @watering = Watering.create(:container_id => @container.id, :leftover => 0, :end_vacation => @end_day, :vacation_days => vaca.to_i, :date => Date.current, :start_vacation => Date.current, :plant_id => disp.plants.first.id)
    end
  end

  
end
