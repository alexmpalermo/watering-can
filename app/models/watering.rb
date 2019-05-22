class Watering < ApplicationRecord
  belongs_to :plant
  belongs_to :container
  validates :vacation_days, numericality: { greater_than: 0 }

  def starting_amount(lr, lc)
    if lr.leftover == 0 && lc.start_amount == 0
      @new_amount = lc.dispenser.capacity
      lc.update(:start_amount => @new_amount, :date => Date.current)
      @new_amount
    else
      lr.leftover
    end
  end


end
