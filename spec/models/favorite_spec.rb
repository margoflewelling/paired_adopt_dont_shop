require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before
  @pet_1 = Pet.create( name: "Holly",
                      age: 4,
                      sex: "Male",
                      shelter_id: @shelter_1.id,
                      image: 'hp.jpg',
                      description: 'Cute',
                      adoptable_status: 'Adoptable')
  @pet_2 = Pet.create( name: "Liza Bear",
                      age: 16,
                      sex: "Female",
                      shelter_id: @shelter_1.id,
                      image: 'hp2.jpg',
                      description: 'Cute',
                      adoptable_status: 'Adoptable')

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

      expect(favorite.favorite_pets).to eq([1, 111, 1111])
    end
  end

end
