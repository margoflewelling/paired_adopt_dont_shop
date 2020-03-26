class Favorite
  attr_reader :favorite_pets

  def initialize(pet_ids = [])
    @favorite_pets = pet_ids
  end

  def total_count
    if @favorite_pets.nil?
      0
    else
      @favorite_pets.length
    end
  end

end
