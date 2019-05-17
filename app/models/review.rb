class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  RATINGS = [0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0]

  validates :rating, :user_id, presence: true
  validates :rating, inclusion: { in: RATINGS }
  validates :content, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed" }

end
