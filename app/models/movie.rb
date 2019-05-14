class Movie < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  accepts_nested_attributes_for :reviews

  validates :title, presence: true, uniqueness: { scope: :release_year, message: "exists with the same release year" }
  validates :release_year, presence: true
end
