class PetsController < ApplicationController

  def index
    @pets = Pet.order('adoption_status')
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    pet = @shelter.pets.create(pet_params_new)
    if pet.save
      redirect_to ("/shelters/#{@shelter.id}/pets")
    else
      flash[:notice] = "Unable to create pet: #{pet.errors.full_messages.to_sentence}."
      render :new
    end
  end

  def edit
    @pet = Pet.find(params[:pet_id])
  end

  def update
    @pet = Pet.find(params[:pet_id])
    @pet.update(pet_params_new)
    if @pet.save
      redirect_to "/pets/#{@pet.id}"
    else
      flash[:notice] = "Unable to update pet: #{@pet.errors.full_messages.to_sentence}."
      render :edit
    end
  end

  def destroy
    Pet.destroy(params[:id])
    favorites.delete_pet(params[:id])
    redirect_to "/pets"
  end

  private

  def pet_params_new
    params.permit(:image, :name, :description, :approximate_age, :sex, :adoption_status)
  end
end
