class Shelter < ApplicationRecord
  has_many :pets
  validates_presence_of :name, :address, :city, :state, :zip

  def adoptable_pets
    pets.select { |pet| pet.adoptable_status == "Adoptable"}
  end

  def pending_pets
    pets.select { |pet| pet.adoptable_status == "Pending Adoption"}
  end
end
