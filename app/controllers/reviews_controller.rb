class ReviewsController < ApplicationController
  before_action :require_login
  before_action :validate_movie
  before_action :validate_review
  before_action :validate_user, only: [:edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :show,]
  skip_before_action :validate_review, only: [:index, :new, :create]

  def index
    respond_to do |format|
      format.html {render 'movies/show'}
      format.json {render json: @movie, status: 200}
    end
  end

  def show
  end

  def new
    @review = @movie.reviews.build
    @label_str = 'Add New Review'
    @btn_class = 'btn btn-success'
  end

  def create
    @review = Review.new(review_params)
    @review.movie = @movie
    if @review.save then
      flash.notice = "New review was created successfully!"
      redirect_to movie_review_path(@movie, @review)
    else
      flash.now.alert = "#{@review.error_msg}"
      @label_str = 'Add New Review'
      @btn_class = 'btn btn-success'
      render :new
    end
  end

  def edit
    @label_str = 'Edit Review'
    @btn_class = 'btn btn-primary'
    render :new
  end

  def update
    if @review.update(review_params) then
      flash.notice = "Review details were updated successfully!"
      redirect_to movie_review_path(@movie, @review)
    else
      flash.now.alert = "#{@review.error_msg}"
      @label_str = 'Edit Review'
      @btn_class = 'btn btn-primary'
      render :new
    end
  end

  def destroy
    if @review.delete then
      flash.notice = "Review was deleted successfully!"
      redirect_to movie_path(@movie)
    else
      flash.alert = "#{@review.error_msg}"
      redirect_to movie_review_path(@movie, @review)
    end
  end

  private

  def validate_review
    @review = @movie.reviews.find_by(id: params[:id])
    if !@review then
      flash.alert = "Requested review does not exist!"
      redirect_to movie_path(@movie)
    end
  end

  def validate_user
    if @review.user != current_user then
      flash.alert = "You are not allowed to modify this review!"
      redirect_to movie_review_path(@movie, @review)
    end
  end

  def review_params
    params.require(:review).permit(:user_id, :content, :rating)
  end

end
