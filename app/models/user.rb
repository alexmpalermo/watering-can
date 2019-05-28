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
      user.dispensers.each do |disp|
        disp.plants.each do |plant|
          if plant.waterings.last.end_vacation > plant.next_water_day.to_date
            self.update(:needs_water => 'true')
          else
            self.update(:needs_water => 'false')
          end
          unless Watering.vacation_over?(disp.id)
            Watering.water(disp.id)
          end
        end
      end
    end
  end

  def vacation_calculate
    @last_container = self.dispensers.first.containers.last
    @last_watering = @last_container.waterings.last
    @last_watering.end_vacation.to_date - Date.current
  end
end
