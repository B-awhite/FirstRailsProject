class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :destination
  validates :content, presence: true

  Comment.new.errors[:content].any?
end
