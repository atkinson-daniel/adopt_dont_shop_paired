class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.reviews.new(new_shelter_params)
    if review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = "Review not created. Title, rating, and content are required."
      render :new
    end
  end

  private

  def new_shelter_params
    params.permit(:title, :rating, :content, :picture)
  end
end
