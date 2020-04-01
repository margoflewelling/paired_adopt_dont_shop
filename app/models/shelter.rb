class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews
  validates_presence_of :name, :address, :city, :state, :zip

  def adoptable_pets
    pets.where(adoptable_status: "Adoptable")
  end

  def pending_pets
    pets.where(adoptable_status: "Pending Adoption")
  end

  def pet_count
    pets.where.not(adoptable_status: "Adopted").count
  end

  def application_count
    not_adopt_pets = pets.where.not(adoptable_status: "Adopted")
    app_count = 0
    not_adopt_pets.each do |pet|
      app_count += pet.applications.length
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
