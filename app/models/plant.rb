class Plant < ApplicationRecord
  belongs_to :dispenser
  has_one :watering
  validates :name, :location, :water_quantity, :water_frequency, presence: true
  scope :water_soon, -> {where(needs_water: 'true')}

  def self.water_today
    @todays = self.water_soon.select {|p| p.water_frequency <= p.days_left.to_i}
    @todays
  end

  def days_left
    day_string = Date.current - self.last_day_watered.to_date
    array = day_string.to_s.split("/")
    array[0]
  end

  def check_water(vacation)
    if (Date.current + vacation.to_i) >= self.next_water_day.to_date
      self.update(:needs_water => 'true')
    else
      self.update(:needs_water => 'false')
    end
  end

  def self.vacation_start(dispenser, vacation)
    dispenser.plants.each do |plant|
      @next = (Date.current + plant.water_frequency)
      plant.update(:last_day_watered => Date.current, :next_water_day => @next)
      plant.check_water(vacation)
    end
  end
end
