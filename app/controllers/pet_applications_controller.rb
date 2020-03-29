class PetApplicationsController < ApplicationController

  def index
    @applications = Application.applications_by_pet(params)
  end

  def update
    pet = Pet.find(params[:id])
    application = Application.find(params[:app_id])
    if pet.adoption_status == "Pending"
      flash[:notice] = "No more applications can be approved for #{pet.name} at this time"
    else
      pet.update_adoption_status(pet, params)
      flash[:notice] = "#{pet.name} is on hold for #{application.name}."
    end
    redirect_to "/pets/#{pet.id}"
  end
end
