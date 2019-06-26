class DispenserSerializer < ActiveModel::Serializer
  attributes :id, :name, :capacity, :product_number
  belongs_to :user
  has_many :plants
  has_many :containers
end
