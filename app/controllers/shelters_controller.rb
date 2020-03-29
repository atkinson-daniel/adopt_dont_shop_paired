class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def add
    @shelter = Shelter.new(shelter_params)
    if @shelter.save
      redirect_to '/shelters'
    else
      flash[:notice] = "Unable to create shelter: Required fields are empty."
      render :new
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
    @reviews = Review.where(shelter_id: @shelter.id)
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    @shelter.update(shelter_params)
    if @shelter.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = "Unable to update shelter: Required fields are empty."
      render :edit
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
    shelter.destroy_associated
    Shelter.destroy(params[:id])
    redirect_to "/shelters"
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
