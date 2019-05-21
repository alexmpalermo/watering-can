class Watering < ApplicationRecord
  belongs_to :plant
  belongs_to :container
end
