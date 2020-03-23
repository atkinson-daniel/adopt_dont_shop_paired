class ShelterPetsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:shelter_id])
  end

  def destroy
    Pet.destroy(params[:pet_id])
    redirect_to "/shelters/#{params[:shelter_id]}/pets"
  end
end
