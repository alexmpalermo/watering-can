class User < ApplicationRecord
  has_many :dispensers
  has_secure_password
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true

  @@greetings = []

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = SecureRandom.hex
    end
  end

  def self.water_everyday
    self.all.each do |user|
      if user.check_disp && user.check_p
        user.dispensers.each do |disp|
          disp.plants.each do |plant|
            if plant.waterings.last.end_vacation.to_date > plant.next_water_day.to_date
              plant.update(:needs_water => 'true')
            else
              plant.update(:needs_water => 'false')
            end
            Watering.water(disp.id) unless Watering.vacation_over?(disp.id)
          end
        end
      end
    end
  end

  def check_disp
    true unless self.dispensers.empty?
  end

  def check_p
    array = self.dispensers.select {|d| d.plants.empty?}
    true if array.empty?
  end

  def vacation_calculate
    @plant = self.dispensers.first.plants.first
    @last_watering = @plant.waterings.last
    @last_watering.end_vacation.to_date
  end


end
