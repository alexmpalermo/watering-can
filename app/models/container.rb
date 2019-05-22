class Container < ApplicationRecord
  belongs_to :dispenser
  has_many :waterings
  has_many :plants, :through => :waterings

  def self.refill(disp)
    refill = self.create(:dispenser_id => disp.id, :start_amount => disp.capacity, :date => Date.current)
    refill
  end 
end
