class ApplicationsController < ApplicationController

  def new
  end

  def create
    pet_ids_applied = params.select {|k,v| v == "1"}.keys
    application = Application.create(application_params)
    pet_names = pet_ids_applied.map {|pet_id| Pet.find(pet_id).name}
    flash[:notice] = "Your application has been processed for #{pet_names.join(", ")}"
    pet_ids_applied.each do |pet_id|
    favorite.remove(pet_id)
    end
    redirect_to "/favorite"
  end



private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
