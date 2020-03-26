class ApplicationsController < ApplicationController

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      favorites.pets_applied(application, params)
      flash.now[:notice] = "Your application for ... has been submitted."
      redirect_to "/favorites"
    else
      flash.now[:notice] = "Unable to submit application: Required fields are empty."
      render :new
    end
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
