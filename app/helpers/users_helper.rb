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


end
