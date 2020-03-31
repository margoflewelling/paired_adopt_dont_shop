require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "#total_count" do
    it "can calculate the total count of pets favorited" do
      favorite = Favorite.new([])

      expect(favorite.total_count).to eq(0)

      favorite = Favorite.new([1, 2, 99])

      expect(favorite.total_count).to eq(3)
    end
  end


  describe "#add_favorite" do
    it "can add pets to the favorite list" do
      favorite = Favorite.new([])

      expect(favorite.favorite_pets).to eq([])

      favorite.add_favorite(1)
      favorite.add_favorite(111)
      favorite.add_favorite(1111)

      expect(favorite.favorite_pets).to eq(["1", "111", "1111"])
    end
  end

  describe "#remove" do
    it "can remove pets from favorites once they have been applied for" do
      favorite = Favorite.new([])
      favorite.add_favorite(1)
      favorite.add_favorite(111)
      favorite.add_favorite(1111)
      favorite.remove(1111)
      favorite.remove(111)
      expect(favorite.favorite_pets).to eq(["1"])
    end
  end



end
