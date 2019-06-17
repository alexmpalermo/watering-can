class User < ApplicationRecord
  has_many :dispensers
  has_secure_password
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = SecureRandom.hex
    end
  end

  def self.water_everyday
    self.all.each do |user|
      if user.check_disp? && user.check_p?
        user.dispensers.each do |disp|
          if !Watering.vacation_over?(disp.id)
            disp.plants.each do |plant|
              plant.check_water(plant.waterings.last.vacation_days.to_i)
            end
            Watering.water(disp)
          end
        end
      end
    end
  end

  def update_vacation_and_plants(vaca)
    self.dispensers.each do |disp|
      Plant.vacation_start(disp, vaca)
      @container = Container.create(:dispenser_id => disp.id, :date => Date.current, :start_amount => 0)
      @end_day = (Date.current + vaca.to_i)
      @watering = Watering.create(:container_id => @container.id, :leftover => 0, :end_vacation => @end_day, :vacation_days => vaca.to_i, :date => Date.current, :start_vacation => Date.current, :plant_id => disp.plants.first.id)
    end
  end

  def check_disp?
    if self.dispensers.empty?
      false
    else
      true
    end
  end

  def check_p?
    array = self.dispensers.select {|d| d.plants.empty?}
    true if array.empty?
  end

  def vacation_calculate
    @plant = self.dispensers.first.plants.first
    @last_watering = @plant.waterings.last
    @last_watering.end_vacation.to_date
  end


end
