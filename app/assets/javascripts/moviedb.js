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
  let avgRating = 0;
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
  console.log("showMovieDetails is running!");
  $("#movie").html(`<a href=\"/movies/${window.movie.id}\">${window.movie.title}</a>`);
  $("#year").text(`Release Year: ${window.movie.release_year}`);
  $("#avgRating").html("Average Rating: " + window.movie.avgStarRatingHtml());
  $("#synopsis").text(window.movie.synopsis);
}

function returnOpposite(param) {
  if (param === "Name") {
    return "Rating";
  }
  if (param === "Rating") {
    return "Name";
  }
  if (param === "ASC") {
    return "DESC";
  }
  if (param === "DESC") {
    return "ASC";
  }
}

function setColumnHeaders(column, direction) {
  let opColumn = returnOpposite(column);
  let opDirection = returnOpposite(direction);
  let arrow = "fa fa-chevron-down";
  if (direction === "ASC") {
    arrow = "fa fa-chevron-up";
  }
  $("#" + column).html(`<a href=\"\" onclick=\"showReviews(\'${column}\', \'${opDirection}\');\">${column} <span class=\"${arrow}\"></span></a>`);
  $("#" + opColumn).html(`<a href=\"\" onclick=\"showReviews(\'${opColumn}\', \'ASC\');\">${opColumn}</a>`);
}

function indexMovieReviews() {
  let tableRows = "";
  window.movie.reviews.forEach(function(review) {
    tableRows += `<tr><td><a href=\"/movies/${window.movie.id}/reviews/${review.id}\">${review.user.name}</a></td><td><a href=\"/movies/${window.movie.id}/reviews/${review.id}\">${review.starRatingHtml()}</a></td></tr>`;
  });
  $("#movieReviews").html(tableRows);
}

function sortByName(a, b) {
  let x = a.user.name.toLowerCase();
  let y = b.user.name.toLowerCase();
  if (x < y) {return -1;}
  if (x > y) {return 1;}
  return 0;
}

function sortColumns(column, direction) {
  window.column = column;
  window.direction = direction;
  if (column === "Name") {
    if (direction === "ASC") {
      window.movie.reviews.sort(function(a, b) {
        return sortByName(a, b);
      });
    } else {
      window.movie.reviews.sort(function(a, b) {
        return sortByName(b, a);
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
}

function showReviews(column = "Name", direction = "ASC") {
  sortColumns(column, direction);
  setColumnHeaders(column, direction);
  indexMovieReviews();
}

function showButtons() {
  $("#buttons").html("<tr class='table-light'><td><button class='btn btn-success' onclick='addNewReview();'>Add New Review</button></td><td><button class='btn btn-primary' onclick='location.href=`/movies/${window.movie.id}/edit`'>Edit Movie</button></td></tr>");
}

function showMessage(data) {
  console.log("showMessage is running!");
  console.log(data);
  $("#message").html($("<div>" + data + "</div>").find("div.alert")[0]);
}

function handleSubmitResponse(data) {
  console.log("handleSubmitResponse is running!");
  console.log(data);
  if (data.hasOwnProperty("responseText")) {
    loadMessage(window.movie.id);
    $.get("/movies/" + window.movie.id + ".json", function(data) {
      window.movie = new Movie(data);
      sortColumns(window.column, window.direction);
      indexMovieReviews();
      addNewReview();
    });
  } else {
    showMessage(data);
    loadForm(data);
  }
}

function submitForm() {
  console.log("submitForm is running!");
  let values = $("#reviewForm input, #reviewForm textarea, #reviewForm select").serialize();
  console.log(values);
  let posting = $.post('/movies/' + window.movie.id + "/reviews", values);
  posting.always(function(data) {
    handleSubmitResponse(data);
  });
}

function cancelAdd() {
  $("#reviewForm").html("");
  $("#message").html("");
  addButtons();
}

function addFormListeners() {
  $("#new_review").on("submit", function(event) {
    event.preventDefault();
    submitForm();
  });
  $(".btn.btn-success").on("click", function(event) {
    event.preventDefault();
    $("#new_review").submit();
  });
}

function loadForm(page) {
  console.log("loadForm is running!");
  $("#reviewForm").html($(page).find("tbody").html());
  $("#reviewForm .table-light td").removeAttr("colspan");
  $("#reviewForm .table-light").append('<td><button class="btn btn-danger" onclick="cancelAdd();">Cancel</button></td>');
  $("#buttons").html("");
  addFormListeners();
}

function addNewReview() {
  console.log("addNewReview is running!");
  $.get("/movies/" + window.movie.id + "/reviews/new", function(page) {
    loadForm(page);
  });
}

function addButtons() {
  $.get('/loggedin_user', function(result) {
    if (result !== null) {
      showButtons();
    }
  });
}

function loadMessage(id) {
  $.get("/movies/" + id + ".html", function(data) {
    showMessage(data);
  });
}

function addEventListeners() {
  $("#Name").on("click", function(event) {
    event.preventDefault();
  });
  $("#Rating").on("click", function(event) {
    event.preventDefault();
  });
}

$(document).on("ready", function() {
  let id = $("#movie").attr("data-id");
  $("#message").html($("div.alert")[0]);
  addEventListeners();
  $.get("/movies/" + id + ".json", function(data) {
    window.movie = new Movie(data);
    showMovieDetails();
    showReviews();
    addButtons();
  });
});
