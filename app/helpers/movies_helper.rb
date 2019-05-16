module MoviesHelper

  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    icon = sort_direction == "asc" ? "fa fa-chevron-up" : "fa fa-chevron-down"
    icon = column == sort_column ? icon : ""
    link_to "#{title} <span class='#{icon}'></span>".html_safe, {column: column, direction: direction}
  end

  def star_rating(rating)
    stars = ""
    full_star = '<span class="fa fa-star"></span>'
    empty_star = '<span class="fa fa-star-o"></span>'
    half_star = '<span class="fa fa-star-half-o"></span>'
    rating.divmod(1).first.to_i.times{stars += full_star}
    stars += half_star if rating.divmod(1).last == 0.5
    (5-rating.round).times{stars += empty_star}
    return stars
  end

end
