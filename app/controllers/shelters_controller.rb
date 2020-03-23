class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def add
    Shelter.create(shelter_params)
    redirect_to '/shelters'
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    @shelter.update(shelter_params)
    redirect_to "/shelters/#{@shelter.id}"
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to "/shelters"
  end

  def shelter_pets_index
    @shelter = Shelter.find(params[:shelter_id])
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
