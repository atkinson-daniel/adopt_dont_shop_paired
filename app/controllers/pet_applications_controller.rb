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
      pet.update_adoption_status("Pending", true, params)
      flash[:notice] = "#{pet.name} is on hold for #{application.name}."
    end
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    application = Application.find(params[:app_id])
    pet.update_adoption_status("Adoptable", false, params)
    redirect_to "/applications/#{application.id}"
  end
end
