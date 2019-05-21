class Plant < ApplicationRecord
  belongs_to :dispenser
  has_many :waterings
  has_many :containers, :through => :waterings
end
