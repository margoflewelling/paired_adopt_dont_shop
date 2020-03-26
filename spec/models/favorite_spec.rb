require 'rails_helper'

RSpec.describe Favorite, type: :model do

  describe "#total_count" do
    it "can calculate the total count of pets favorited" do
      favorite = Favorite.new

      expect(favorite.total_count).to eq(0)

      favorite = Favorite.new([1, 2, 99])

      expect(favorite.total_count).to eq(3)
    end
  end

end
