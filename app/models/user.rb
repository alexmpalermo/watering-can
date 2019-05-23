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

  def start_loop
    self.dispensers.each do |disp|
      Watering.water_loop(disp.id)
    end
  end

  def vacation_calculate
    @last_container = self.dispensers.first.containers.last
    @last_watering = @last_container.waterings.last
    @last_watering.end_vacation - Date.current
  end

end
