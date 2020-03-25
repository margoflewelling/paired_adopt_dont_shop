class Pet < ApplicationRecord
  belongs_to :shelter

  validates_presence_of :name, :age, :sex, :description, :image

  validates_inclusion_of :sex,
    in: ['Male', 'male', 'MALE', 'Female', 'female', 'FEMALE']

  validates_inclusion_of :adoptable_status,
    in: ['Adoptable', 'Pending Adoption', 'Adopted']

  def shelter_name
    shelter.name
  end
end
