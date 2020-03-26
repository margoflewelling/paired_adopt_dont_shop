require 'rails_helper'

RSpec.describe "Favorites Index - A user", type: :feature do
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


  it "can see a list of all favorited pets" do
    visit "/favorites"
    expect(page).to_not have_content(@pet_1.name)
    visit "/pets/#{@pet_1.id}"
    click_button 'Favorite'

    visit "/favorites"
    within ".pet-#{@pet_1.id}" do
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_css("img[src='#{@pet_1.image}']")
    end

    click_link("#{@pet_1.name}")
    expect(page).to have_current_path("/pets/#{@pet_1.id}")
  end


end
