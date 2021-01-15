class Destination < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments 
  validates_presence_of :location, :city
end
