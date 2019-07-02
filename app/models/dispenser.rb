class Dispenser < ApplicationRecord
  belongs_to :user
  has_many :plants
  validates :name, :product_number, :capacity, presence: true
  validates :product_number, uniqueness: true
  validates :vacation_days, numericality: { greater_than_or_equal_to: 0 }

  def vacation_over?
    Plant.water_soon.where(:dispenser_id => self.id).empty?
  end

  def see_amount(plant)
    if plant.water_quantity > self.current_amount
      the_leftover = plant.water_quantity - self.current_amount
      self.update(:current_amount => (self.capacity - the_leftover), :date_refilled => Date.current)
    else
      self.update(:current_amount => (self.capacity - plant.water_quantity))
    end
  end

  def water
    if @plants = Plant.water_today.select {|p| p.dispenser == self}
      @plants.each do |plant|
        @days_array = (self.end_vacation.to_date - Date.current).to_s.split("/")
        self.update(:vacation_days => @days_array[0].to_i)
        self.see_amount(plant)
        plant.update(:last_day_watered => Date.current, :next_water_day => (Date.current + plant.water_frequency))
        plant.check_water(self.vacation_days)
      end
    end
  end
end
