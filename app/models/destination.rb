class Destination < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments 
  validates_presence_of :location, :city

  scope :alpha, -> {order(:location)}
  scope :most_comments, -> {joins(:comments).group('destinations.id').order('count(destinations.id) desc')}
end
