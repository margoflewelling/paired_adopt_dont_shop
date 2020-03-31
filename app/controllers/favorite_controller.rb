class FavoriteController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    favorite.add_favorite(pet.id)
    session[:favorite] = favorite.favorite_pets
    flash[:notice] = "#{pet.name} has been added to your favorites list."
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def index
    @favorites = favorite.favorite_pets
    @pets = Pet.all
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorite.favorite_pets.delete(params[:pet_id])
    session[:favorite] = favorite.favorite_pets
    flash[:notice] = "#{pet.name} has been removed from your favorites"
    if params[:state] == "index_redirect"
      redirect_to "/favorite"
    else
      redirect_to "/pets/#{params[:pet_id]}"
    end
  end

  def destroy_all
    session[:favorite] = []
    redirect_to "/favorite"
  end
end
