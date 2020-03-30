class PetsController < ApplicationController

  def index
    @pets = Pet.all.sort_by { |pet| pet.adoption_status }
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    @shelter.pets.create(pet_params_new)
    redirect_to ("/shelters/#{@shelter.id}/pets")
  end

  def edit
    @pet = Pet.find(params[:pet_id])
  end

  def update
    @pet = Pet.find(params[:pet_id])
    @pet.update(pet_params_new)
    redirect_to "/pets/#{@pet.id}"
  end

  def adoption_status_pending
    @pet = Pet.find(params[:pet_id])
    @pet.update(adoption_status: "Pending")
    redirect_to "/pets/#{@pet.id}"
  end

  def adoption_status_adoptable
    @pet = Pet.find(params[:pet_id])
    @pet.update(adoption_status: "Adoptable")
    redirect_to "/pets/#{@pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    favorites.delete_pet(params[:id])
    redirect_to "/pets"
  end

  private
  def pet_params_new
    params[:adoption_status] = "Adoptable"
    params.permit(:image, :name, :description, :approximate_age, :sex, :adoption_status)
  end

  def change_adoption_status
  end
end
