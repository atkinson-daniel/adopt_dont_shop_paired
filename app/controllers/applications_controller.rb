class ApplicationsController < ApplicationController

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      favorites.pets_applied(application, params)
      flash[:notice] = "Your application for #{pets_applied_for} has been submitted."
      redirect_to "/favorites"
    else
      flash[:notice] = "Unable to create application: #{application.errors.full_messages.to_sentence}."
      render :new
    end
  end

  def show
    @application = Application.find(params[:application_id])
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end

  def pets_applied_for
    pets = []
    params.each do |key, value|
      if value == "applied"
        pets << Pet.find(key).name
      end
    end
    pets.to_sentence
  end
end
