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
end
