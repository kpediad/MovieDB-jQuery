class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :release_year, :synopsis
end
