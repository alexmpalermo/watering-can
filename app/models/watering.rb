class Watering < ApplicationRecord
  belongs_to :plant
  belongs_to :container
  validates :vacation_days, numericality: { greater_than_or_equal_to: 0 }

  def starting_amount(lr, lc)
    if lr.leftover == 0 && lc.start_amount == 0
      @new_amount = lc.dispenser.capacity
      lc.update(:start_amount => @new_amount, :date => Date.current)
      @new_amount
    else
      lr.leftover
    end
  end

  def self.water(disp_id)
    if @plants = Plant.water_today.select {|p| p.dispenser_id == disp_id}
      @dispenser = Dispenser.find_by_id(disp_id)
      @container = @dispenser.containers.last
      @last = @container.waterings.last
      @plants.each do |plant|
        @watering = Watering.new(:plant_id => plant.id, :date => Date.current, :container_id => @container.id, :end_vacation => @last.end_vacation, :start_vacation => @last.start_vacation, :leftover => 0)
        @this = @last.end_vacation.to_date - Date.current
        @days_array = @this.to_s.split("/")
        @watering.vacation_days = @days_array[0]
        @watering.save
        @watering.update(:leftover => (@watering.starting_amount(@last, @container) - plant.water_quantity))
        @next = (@watering.date.to_date + plant.water_frequency)
        plant.update(:last_day_watered => @watering.date, :next_water_day => @next)
        if @watering.leftover < 0
          @disp = Dispenser.find_by_id(@watering.container.dispenser_id)
          @c_new = Container.refill(@disp)
          @new_leftover = (@c_new.start_amount + @watering.leftover)
          @w_new = Watering.create(:plant_id => plant.id, :container_id => @c_new.id, :vacation_days => @watering.vacation_days, :start_vacation => @watering.start_vacation, :end_vacation => @watering.end_vacation, :date => @watering.date, :leftover => @new_leftover)
          plant.check_water(@w_new.vacation_days)
        else
          plant.check_water(@watering.vacation_days)
        end
      end
    end
  end

  def self.vacation_over?(disp_id)
    if Plant.water_soon.where(:dispenser_id => disp_id)
      false
    else
      true
    end
  end

end
