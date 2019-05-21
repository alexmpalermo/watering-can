class User < ApplicationRecord
  has_many :dispensers
  has_secure_password
  
end
