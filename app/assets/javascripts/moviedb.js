$(document).ready(function() {
  console.log("READY!");
});

function Review(content, rating) {
  this.content = content;
  this.rating = rating;
}

Review.prototype.starRatingHtml = function() {
  console.log('Dummy starRatingHtml');
};

function Movie(title, releaseYear, synopsis, reviews) {
  this.title = title;
  this.releaseYear = releaseYear;
  this.synopsis = synopsis;
  this.reviews = reviews;
}

Movie.prototype.averageRating = function() {
  console.log('Dummy averageRating');
};

Movie.prototype.avgStarRatingHtml = function() {
  console.log('Dummy avgStarRatingHtml');
};
