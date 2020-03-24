class SheltersController < ApplicationController

  def index
    @shelters = Shelter.all
  end

  def new; end

  def create
    shelter = Shelter.new({
                    name: create_params[:name],
                    address: create_params[:address],
                    city: create_params[:city],
                    state: create_params[:state],
                    zip: create_params[:zip]
                  })
    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter[:name] = update_params[:name]
    shelter[:address] = update_params[:address]
    shelter[:city] = update_params[:city]
    shelter[:state] = update_params[:state]
    shelter[:zip] = update_params[:zip]
    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    Shelter.find(params[:id]).pets.each { |pet| pet.destroy }
    Shelter.destroy(params[:id])
    redirect_to "/shelters"
  end

  private

  def create_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def update_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
