class MoviesController < ApplicationController
  before_action :require_login
  before_action :validate_movie, only: [:edit, :update, :show]
  skip_before_action :require_login, only: [:index, :show,]

  def new
    @movie = Movie.new
    @reviews = @movie.reviews.build
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save then
      flash.notice = "New movie was created successfully!"
      redirect_to movies_path
    else
      flash.now.alert = "#{@movie.error_msg}"
      render :new
    end
  end

  def edit
    @reviews = @movie.user_reviews(current_user)
    @edit = true
    render :new
  end

  def update
    #raise params.inspect
    if @movie.update(movie_params) then
      flash.notice = "Movie details were updated successfully!"
      redirect_to movie_path(@movie)
    else
      flash.now.alert = "#{@movie.error_msg}"
      render :edit
    end
  end

  def index
    if sort_column == 'avg_rating' then
      @movies = Movie.all.sort_by(&:avg_rating) if sort_direction == 'asc'
      @movies = Movie.all.sort_by(&:avg_rating).reverse if sort_direction == 'desc'
    else
      @movies = Movie.order("#{sort_column} #{sort_direction}")
    end
  end

  def show
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :release_year, :synopsis, reviews_attributes: [:user_id, :content, :rating, :id])
  end

end
