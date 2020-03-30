class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews
  validates_presence_of :name, :address, :city, :state, :zip

  def adoptable_pets
    pets.select { |pet| pet.adoptable_status == "Adoptable"}
  end

  def pending_pets
    pets.select { |pet| pet.adoptable_status == "Pending Adoption"}
  end

  def shelter_reviews
    reviews.each { |review| review }
  end

  def pet_count
    pets.select { |pet| pet.adoptable_status != "Adopted"}.length
  end

  def application_count
    app_count = 0
    pets.each do |pet|
      if pet.adoptable_status != "Adopted"
        app_count += pet.applications.length
      end
    end
    app_count
  end

  def average_rating
    if reviews.length >= 1
      reviews.average(:rating)
    else
      0
    end
  end
end
