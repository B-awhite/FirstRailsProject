class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :destination
  validates :content, presence: true
end
