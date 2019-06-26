class PlantSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :water_quantity, :water_frequency
  belongs_to :dispenser
  has_many :waterings
  has_many :containers, :through => :waterings
end
