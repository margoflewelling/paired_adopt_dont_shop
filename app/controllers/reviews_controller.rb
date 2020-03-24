class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    @review = @shelter.reviews.new(review_params)
    @review.save
    redirect_to "/shelters/#{review_params[:id]}"
  end


private

  def review_params
    params.permit(:title, :rating, :content, :image, :id)
  end

end
