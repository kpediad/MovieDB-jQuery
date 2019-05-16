class ReviewsController < ApplicationController
  before_action :require_login
  before_action :validate_params_and_user, only: [:edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :show,]

  def index
    @movie = Movie.find(params[:movie_id])
    render 'movies/show'
  end

  def show
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.find(params[:id])
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build
  end

  def create
    raise params.inspect

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def validate_params_and_user
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.find(params[:id])
    if @review.user != current_user then


  end

  def review_params
    params.require(:review).permit(:user_id, :content, :rating]) #temporary as need to test what needs to happen with movie_id
  end

end
