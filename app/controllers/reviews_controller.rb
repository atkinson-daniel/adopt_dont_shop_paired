class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    shelter.reviews.create(new_shelter_params)

    redirect_to "/shelters/#{shelter.id}"
  end

  private

  def new_shelter_params
    params.permit(:title, :rating, :content, :picture)
  end
end
