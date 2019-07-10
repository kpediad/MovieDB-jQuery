function Review(review) {
  this.id = review.id;
  this.content = review.content;
  this.rating = Number(review.rating);
  this.user = review.user;
}

Review.prototype.starRatingHtml = function() {
  let stars = "";
  let starIndex = 5;
  let full_star = '<span class="fa fa-star"></span>';
  let empty_star = '<span class="fa fa-star-o"></span>';
  let half_star = '<span class="fa fa-star-half-o"></span>';
  for (let i = 0; i < Math.floor(this.rating); i++) {
    stars += full_star;
    starIndex--;
  }
  if (this.rating - Math.floor(this.rating) === 0.5) {
    stars += half_star;
    starIndex--;
  }
  for (let i = 0; i < starIndex; i++) {
    stars += empty_star;
  }
  return stars;
};

function Movie(data) {
  this.id = data.id;
  this.title = data.title;
  this.release_year = data.release_year;
  this.synopsis = data.synopsis;
  let reviewsArray = [];
  data.reviews.forEach(function(review, index) {
    reviewsArray[index] = new Review(review);
  });
  this.reviews = reviewsArray;
}

Movie.prototype.averageRating = function() {
  let avgRating = 0
  this.reviews.forEach(function(review) {
    avgRating += review.rating;
  });
  return Math.round((avgRating / this.reviews.length) * 2) / 2;
};

Movie.prototype.avgStarRatingHtml = function() {
  let stars = "";
  let starIndex = 5;
  let full_star = '<span class="fa fa-star"></span>';
  let empty_star = '<span class="fa fa-star-o"></span>';
  let half_star = '<span class="fa fa-star-half-o"></span>';
  let avgRating = this.averageRating();
  for (let i = 0; i < Math.floor(avgRating); i++) {
    stars += full_star;
    starIndex--;
  }
  if (avgRating - Math.floor(avgRating) === 0.5) {
    stars += half_star;
    starIndex--;
  }
  for (let i = 0; i < starIndex; i++) {
    stars += empty_star;
  }
  return stars;
};

function showMovieDetails(movie) {
  $("#movie").append(`<a href=\"/movies/${movie.id}\">${movie.title}</a>`);
  $("#year").text(`Release Year: ${movie.release_year}`);
  $("#avgRating").append("Average Rating: " + movie.avgStarRatingHtml());
  $("#synopsis").text(movie.synopsis);
}

$(document).on('turbolinks:load', function() {
  let id = $("#movie").attr("data-id");
  $.get("/movies/" + id + ".json", function(data) {
    let movie = new Movie(data);
    showMovieDetails(movie);
  });
});
