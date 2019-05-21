class Container < ApplicationRecord
  belongs_to :dispenser
  has_many :waterings
  has_many :plants, :through => :waterings
end
