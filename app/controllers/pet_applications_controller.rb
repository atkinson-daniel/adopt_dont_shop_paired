class PetApplicationsController < ApplicationController

  def index
    @applications = Application.applications_by_pet(params)
  end

end
