class Dispenser < ApplicationRecord
  belongs_to :user
  has_many :plants
  has_many :containers
end
