class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  validates_presence_of :name, :age, :sex, :description, :image


  def shelter_name
    shelter.name
  end

  def application_lookup(pet)
    applications.find(pet.accepted_app_id)
  end


end
