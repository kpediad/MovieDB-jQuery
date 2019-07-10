function Review(review) {
  this.id = review.id;
  this.content = review.content;
  this.rating = Number(review.rating);
  this.user = review.user;
}

Review.prototype.starRatingHtml = function() {
  console.log('Dummy starRatingHtml');
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
  console.log('Dummy averageRating');
};

Movie.prototype.avgStarRatingHtml = function() {
  console.log('Dummy avgStarRatingHtml');
};

$(document).ready(function() {
  console.log("READY!");
  let id = $("#movie").attr("data-id");
  console.log(id);
  $.get("/movies/" + id + ".json", function(data) {
    console.log(data);
    let movie = new Movie(data);
    console.log(movie);
  });
});
