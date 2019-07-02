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
          if !disp.vacation_over?
            disp.plants.each do |plant|
              plant.check_water(disp.vacation_days.to_i)
            end
            disp.water
          end
        end
      end
    end
  end

  def update_vacation_and_plants(vaca)
    self.dispensers.each do |disp|
      Plant.vacation_start(disp, vaca)
      @end_day = (Date.current + vaca.to_i)
      disp.update(:date_refilled => Date.current, :current_amount => 0, :vacation_days => vaca.to_i, :end_vacation => @end_day, :start_vacation => Date.current)
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
    self.dispensers.first.end_vacation.to_date
  end


end
