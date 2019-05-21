class Dispenser < ApplicationRecord
  belongs_to :user
  has_many :plants
  has_many :containers
  validates :name, :product_number, :capacity, presence: true
  validates :product_number, uniqueness: true 

end
