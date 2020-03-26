require 'rails_helper'

RSpec.describe "Favorites - A user", type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create( name: "Henry Porter's Puppies",
                                address: "1315 Monaco Parkway",
                                city: "Denver",
                                state: "CO",
                                zip: "80220"
                              )
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
  end

  it "can see a zero in the nav bar if it hasn't favorited any pets" do
    visit "/pets"

    within "nav" do
      within ".favorite" do
        expect(page).to have_content("0")
      end
    end

    visit "/shelters"

    within "nav" do
      within ".favorite" do
        expect(page).to have_content("0")
      end
    end
  end

  it "can favorite pets" do
    visit "/pets/#{@pet_1.id}"
    click_button 'Favorite'

    expect(page).to have_content("#{@pet_1.name} has been added to your favorites list.")
  end

end
