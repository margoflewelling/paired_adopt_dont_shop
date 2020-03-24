class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    pet = Pet.new({
                    name: create_params[:name],
                    age: create_params[:age],
                    sex: create_params[:sex],
                    description: create_params[:description],
                    image: create_params[:image],
                    adoptable_status: "Adoptable",
                    shelter_id: create_params[:id]
                  })
    pet.save
    redirect_to "/shelters/#{create_params[:id]}/pets"
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet[:name] = update_params[:name]
    pet[:age] = update_params[:age]
    pet[:sex] = update_params[:sex]
    pet[:description] = update_params[:description]
    pet[:image] = update_params[:image]
    pet[:adoptable_status] = update_params[:adoptable_status]

    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to "/pets"
  end

  private

  def create_params
    params.permit(:name, :age, :sex, :description, :image, :id)
  end

  def update_params
    params.permit(:name, :age, :sex, :description, :image, :adoptable_status)
  end
end
