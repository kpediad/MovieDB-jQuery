class MoviesController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:index, :show,]

  def new
    @movie = Movie.new
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
  end

  def update
  end

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

end
