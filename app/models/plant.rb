class Plant < ApplicationRecord
  belongs_to :dispenser
  has_many :waterings
  has_many :containers, :through => :waterings
  validates :name, :location, :water_quantity, :water_frequency, presence: true
  scope :water_soon, -> {where(needs_water: 'true')}

  def self.water_today
    @need_w = self.all.select {|p| p.needs_water == "true"}
    @todays = @need_w.select {|p| p.water_frequency >= p.days_left}
    @todays
  end

  def days_left
    Date.current - self.last_day_watered
  end

  def check_water(vacation)
    if (Date.current + vacation.to_i) > self.next_water_day.to_date
      self.update(:needs_water => 'true')
    else
      self.update(:needs_water => 'false')
    end
  end

  def self.vacation_start(pd, pv)
    @plants = []
    @plants << Plant.all.find_by(:dispenser_id => pd)
    @plants.each do |plant|
      @next = (Date.current + plant.water_frequency)
      plant.update(:last_day_watered => Date.current, :next_water_day => @next)
      plant.check_water(pv)
    end
  end
end
