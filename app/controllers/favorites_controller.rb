class FavoritesController < ApplicationController

  def index
    @pets = favorites.all_favorited_pets
  end

  def update
    @pet = Pet.find(params[:pet_id])
    session[:favorites] ||= []
    session[:favorites] << @pet
    flash[:notice] = "#{@pet.name} has been added to your favorites list."
    redirect_to "/pets/#{@pet.id}"
  end

  def destroy
    favorites.contents.clear
    redirect_to "/favorites"
  end

  def remove
    favorites.delete_pet(params[:pet_id])
    flash[:notice] = "#{Pet.find(params[:pet_id]).name} has been removed from your favorites."
    redirect_back fallback_location: '/favorites'
  end
end
