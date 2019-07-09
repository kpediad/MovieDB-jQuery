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
