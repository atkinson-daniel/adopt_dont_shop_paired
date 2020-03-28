class PetApplicationsController < ApplicationController

  def index
    @applications = Application.applications_by_pet(params)
  end

  def update
    pet = Pet.find(params[:id])
    application = Application.find(params[:app_id])
    pet.update_adoption_status(pet, params)
    flash[:notice] = "#{pet.name} is on hold for #{application.name}."
    redirect_to "/pets/#{pet.id}"
  end

end
