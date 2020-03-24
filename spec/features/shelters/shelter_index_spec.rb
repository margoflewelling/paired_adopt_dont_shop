require 'rails_helper'

RSpec.describe "SHELTERS index page - A user", type: :feature do

  before(:each) do
    @shelter_1 = Shelter.create( name: "Henry Porter's Puppies",
                                address: "1315 Monaco Parkway",
                                city: "Denver",
                                state: "CO",
                                zip: "80220"
                              )
    @shelter_2 = Shelter.create( name: "Holly's Homeless Animals",
                                address: "55400 Township Rd 456",
                                city: "Coshocton",
                                state: "OH",
                                zip: "43812"
                              )
    @pet_1 = Pet.create( name: "Holly",
                        age: 4,
                        sex: "Male",
                        shelter_id: @shelter_1.id,
                        image: 'hp.jpg',
                        description: 'Cute',
                        adoptable_status: 'Adoptable')
  end

  it "can see the name of each shelter in the system" do
    visit "/shelters"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
  end

  it "can click clink to create a new shelter", type: :feature do
    visit "/shelters"
    click_link "New Shelter"

    expect(page).to have_current_path("/shelters/new")
  end

  it "can click to edit an existing shelter", type: :feature do
    visit "/shelters"
    within("##{@shelter_1.id}") do
      click_link "Edit Shelter"
    end

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/edit")

    visit "/shelters"
    within("##{@shelter_2.id}") do
      click_link "Edit Shelter"
    end

    expect(page).to have_current_path("/shelters/#{@shelter_2.id}/edit")
  end

  it "can click to delete an existing shelter", type: :feature do
    visit "/shelters"
    within("##{@shelter_1.id}") do
      click_link "Delete Shelter"
    end

    expect(page).to have_current_path("/shelters")
    expect(page).not_to have_content(@shelter_1.name)


    visit "/shelters"
    within("##{@shelter_2.id}") do
      click_link "Delete Shelter"
    end

    expect(page).to have_current_path("/shelters")
    expect(page).not_to have_content(@shelter_2.name)
  end

  it "can click to show an existing shelter", type: :feature do
    visit "/shelters"
    within("##{@shelter_1.id}") do
      click_link "#{@shelter_1.name}"
    end

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}")
  end
end
