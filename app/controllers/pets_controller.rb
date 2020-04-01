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
    if pet.save
      redirect_to "/shelters/#{params[:shelter_id]}/pets"
    else
      flash[:notice] = "The following fields are incomplete: #{missing_fields(validate_params)}"
      redirect_to "/shelters/#{shelter.id}/pets/new"
    end
  end

  def show
    @pet = Pet.find(params[:pet_id])

  end

  def edit
    @pet = Pet.find(params[:pet_id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    if missing_fields(validate_params).length > 0
      flash[:notice] = "The following fields are incomplete: #{missing_fields(validate_params)}"
      redirect_to "/pets/#{pet.id}/edit"
    else
      pet.update(pet_params)
      redirect_to "/pets/#{pet.id}"
    end
  end

  def destroy
    Pet.destroy(params[:pet_id])
    favorite.remove(params[:pet_id])
    redirect_to "/pets"
  end

  def submit_app
    @pet = Pet.find(params[:pet_id])
    @pet.update_attributes(:adoptable_status => "Pending Adoption")
    @pet.update_attributes(:accepted_app_id => params[:application_id])
    redirect_to "/pets/#{@pet.id}"
  end

  def revoke_app
    @pet = Pet.find(params[:pet_id])
    @pet.update_attributes(:adoptable_status => "Adoptable")
    @pet.update_attributes(:accepted_app_id => nil)
    redirect_to "/applications/#{params[:application_id]}"
  end

  private

  def pet_params
    params.permit(:name, :age, :sex, :description, :image, :id, :adoptable_status, :accepted_app_id)
  end

  def validate_params
    params.permit(:name, :age, :sex, :description, :image)
  end
end
