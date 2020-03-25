class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.reviews.new(review_params)
    if review.save
      redirect_to "/shelters/#{review_params[:shelter_id]}"
    else
      flash.now[:notice] = "Please enter a title, rating, and description."
      render :new
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    review.update(review_params)
    redirect_to "/shelters/#{review.shelter_id}"
  end

  def destroy
    Review.destroy(params[:review_id])
    redirect_to "/shelters/#{params[:shelter_id]}"
  end


private

  def review_params
    params.permit(:title, :rating, :content, :image, :shelter_id, :id)
  end

end
