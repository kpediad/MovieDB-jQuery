class Movie < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  accepts_nested_attributes_for :reviews

  validates :title, presence: true, uniqueness: { scope: :release_year, message: "exists with the same release year" }
  validates :release_year, presence: true, inclusion: { in: 1895..Time.now.year, message: "needs to be between 1895 and #{Time.now.year}" }
  validates :synopsis, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed" }

  def avg_rating
    avg = self.reviews.average(:rating) || 0.0
    (avg * 2).round / 2.0
  end

  def reviews_with_name
    self.reviews.joins(:user)
  end
end
