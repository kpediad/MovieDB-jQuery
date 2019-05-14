class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :rating, :movie_id, :user_id, presence: true

end
