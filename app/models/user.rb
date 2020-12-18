class User < ApplicationRecord
   has_many :destinations
   has_many :comments 
   has_many :commented_destinations, through: :comments, source: :destination
   has_secure_password
end
