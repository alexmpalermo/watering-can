class Plant < ApplicationRecord
  belongs_to :dispenser
  has_many :waterings
  has_many :containers, :through => :waterings
  validates :name, :location, :water_quantity, :water_frequency, presence: true
  scope :water_soon, -> {where(needs_water: 'true')}
  scope :water_today, -> {water_soon.where('water_frequency <= days_left')}

  def days_left
    Date.current - self.last_day_watered
  end

  def check_water(vacation)
    if (vacation + Date.current) > self.next_water_day
      self.update(:needs_water => 'true')
    else
      self.update(:needs_water => 'false')
    end
  end

  def self.vacation_start(pd, pv)
    @plants = self.all.find(:dispenser_id => pd)
    @plants.each do |plant|
      d = (Date.current + plant.water_frequency)
      plant.update(:last_day_watered => Date.current, :next_water_day => d)
      plant.check_water(pv)
    end
  end 
end
