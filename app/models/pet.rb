class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  validates_presence_of :name, :age, :sex, :description, :image

  validates_inclusion_of :sex,
    in: ['Male', 'male', 'MALE', 'Female', 'female', 'FEMALE']

  validates_inclusion_of :adoptable_status,
    in: ['Adoptable', 'Pending Adoption', 'Adopted']

  def shelter_name
    shelter.name
  end

  def application_lookup(pet)
    applications.find(pet.accepted_app_id)
  end


end
