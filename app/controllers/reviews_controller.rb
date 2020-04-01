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
      flash.now[:notice] = "Unable to create review: #{review.errors.full_messages.to_sentence}."
      render :new
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    @review = Review.find(params[:review_id])
    if @review.update(review_params)
      redirect_to "/shelters/#{@review.shelter.id}"
    else
      flash[:notice] = "Unable to save review: #{@review.errors.full_messages.to_sentence}."
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
    if params[:picture] == ""
      params[:picture] = "https://i0.wp.com/happening-news.com/wp-content/uploads/2019/04/Screen-Shot-2019-04-09-at-2.57.27-PM.png?resize=543%2C531&ssl=1"
    end
    params.permit(:title, :rating, :content, :picture)
  end
end
