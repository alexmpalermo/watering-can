class DispenserSerializer < ActiveModel::Serializer
  attributes :id, :name
  belongs_to :user
  has_many :plants
  has_many :containers 
end
