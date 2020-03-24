class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.reviews.new(review_params)
    if review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = "Review not created. Title, rating, and content are required."
      render :new
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    @review = Review.find(params[:review_id])
    @review.update(review_params)
      if @review.save
        redirect_to "/shelters/#{@review.shelter.id}"
      else
        flash[:notice] = "Review not saved: Required information missing."
        render :edit
      end
  end

  def destroy
    @shelter = Shelter.find(params[:shelter_id])
    Review.destroy(params[:review_id])
    redirect_to "/shelters/#{@shelter.id}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :picture)
  end
end
