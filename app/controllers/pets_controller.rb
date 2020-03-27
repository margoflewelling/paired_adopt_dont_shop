class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = shelter.pets.create(pet_params)
    pet.adoptable_status = "Adoptable"
    pet.save
    redirect_to "/shelters/#{params[:shelter_id]}/pets"
  end

  def show
    @pet = Pet.find(params[:pet_id])
  end

  def edit
    @pet = Pet.find(params[:pet_id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet.update(pet_params)
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:pet_id])
    redirect_to "/pets"
  end

  private

  def pet_params
    params.permit(:name, :age, :sex, :description, :image, :id, :adoptable_status)
  end
end
