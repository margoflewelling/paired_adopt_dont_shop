class Favorite
  attr_reader :favorite_pets

  def initialize(pet_ids)
    @favorite_pets = pet_ids ||= Array.new
  end

  def total_count
    if @favorite_pets.nil?
      0
    else
      @favorite_pets.length
    end
  end

  def add_favorite(pet_id)
    @favorite_pets << (pet_id).to_s
  end

end
