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

function showMovieDetails() {
  $("#movie").html(`<a href=\"/movies/${window.movie.id}\">${window.movie.title}</a>`);
  $("#year").text(`Release Year: ${window.movie.release_year}`);
  $("#avgRating").html("Average Rating: " + window.movie.avgStarRatingHtml());
  $("#synopsis").text(window.movie.synopsis);
}

function setColumnHeaders(column, direction) {
  if (column === "name") {
    if (direction === "ASC") {
      $("#colName").html(`<a href=\"\" onclick=\"sortColumns(\'name\', \'DESC\');\">Name <span class=\"fa fa-chevron-up\"></span></a>`);
    } else {
      $("#colName").html(`<a href=\"\" onclick=\"sortColumns(\'name\', \'ASC\');\">Name <span class=\"fa fa-chevron-down\"></span></a>`);
    }
    $("#colRating").html(`<a href=\"\" onclick=\"sortColumns(\'rating\', \'ASC\');\">Rating</a>`);
  } else {
    if (direction === "ASC") {
      $("#colRating").html(`<a href=\"\" onclick=\"sortColumns(\'rating\', \'DESC\');\">Rating <span class=\"fa fa-chevron-up\"></span></a>`);
    } else {
      $("#colRating").html(`<a href=\"\" onclick=\"sortColumns(\'rating\', \'ASC\');\">Rating <span class=\"fa fa-chevron-down\"></span></a>`);
    }
    $("#colName").html(`<a href=\"\" onclick=\"sortColumns(\'name\', \'ASC\');\">Name</a>`);
  }
}

function sortColumns(column, direction) {
  console.log(column + direction);
  let sortedReviews = [];
  if (column === "name") {
    if (direction === "ASC") {
      window.movie.reviews.sort(function(a, b) {
        let x = a.user.name.toLowerCase();
        let y = b.user.name.toLowerCase();
        if (x < y) {return -1;}
        if (x > y) {return 1;}
        return 0;
      });
    } else {
      window.movie.reviews.sort(function(a, b) {
        let x = a.user.name.toLowerCase();
        let y = b.user.name.toLowerCase();
        if (x < y) {return 1;}
        if (x > y) {return -1;}
        return 0;
      });
    }
  } else {
    if (direction === "ASC") {
      window.movie.reviews.sort(function(a, b) {
        return a.rating - b.rating;
      });
    } else {
      window.movie.reviews.sort(function(a, b) {
        return b.rating - a.rating;
      });
    }
  }
  console.log(window.movie.reviews);
  setColumnHeaders(column, direction);
  indexMovieReviews();
}

function indexMovieReviews() {

}

$(document).on('turbolinks:load', function() {
  let id = $("#movie").attr("data-id");
  $.get("/movies/" + id + ".json", function(data) {
    window.movie = new Movie(data);
    $("#colName").on("click", function(event){
      event.preventDefault()
    });
    $("#colRating").on("click", function(event){
      event.preventDefault()
    });
    showMovieDetails();
    sortColumns("name", "ASC");
  });
});
