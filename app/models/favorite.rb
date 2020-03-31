class Favorite
  attr_reader :favorite_pets

  def initialize(pet_ids)
    @favorite_pets = pet_ids ||= Array.new
  end

  def total_count
    @favorite_pets.length
  end

  def add_favorite(pet_id)
    @favorite_pets << (pet_id).to_s
  end

  def remove(pet_id)
    favorite_pets.delete(pet_id.to_s)
  end
end
