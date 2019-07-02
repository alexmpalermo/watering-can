class PlantSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :water_quantity, :water_frequency, :last_day_watered, :next_water_day, :dispenser_id
  belongs_to :dispenser

end
