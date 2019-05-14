class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :rating, :movie_id, :user_id, presence: true
  validates :rating, inclusion: { in: [0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0] }
  validates :content, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed" }

end
