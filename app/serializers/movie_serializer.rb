class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :release_year, :synopsis
  has_many :reviews
end
