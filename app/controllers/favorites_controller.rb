class FavoritesController < ApplicationController

  def index
    @pets = Pet.favorited?
  end

  def new
    @pet = Pet.find(params[:pet_id])
    @pet[:favorited] = true
    @pet.save
    flash[:notice] = "#{@pet.name} has been added to your favorites list."
    redirect_to "/pets/#{@pet.id}"
  end
end
