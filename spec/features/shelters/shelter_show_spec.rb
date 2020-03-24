require 'rails_helper'

RSpec.describe "SHELTERS show page - A user", type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create( name: "Henry Porter's Puppies",
                                address: "1315 Monaco Parkway",
                                city: "Denver",
                                state: "CO",
                                zip: "80220"
                              )
  end

  it "can see the details of a specific shelter" do
    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)
  end

  it "can update existing shelters" do
    visit "/shelters/#{@shelter_1.id}"
    click_link "Update Shelter"

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/edit")

    fill_in('address', :with => "1765 Larimer St")
    fill_in('zip', :with => "80202")
    click_button "Update Shelter"

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}")
    expect(page).to have_content("1765 Larimer St")
    expect(page).to have_content("80202")
  end

  it "can delete a sheleter" do
    visit "/shelters"

    expect(page).to have_content(@shelter_1.name)

    visit "/shelters/#{@shelter_1.id}"
    click_link "Delete Shelter"

    expect(page).to have_current_path("/shelters")
    expect(page).not_to have_content(@shelter_1.name)
  end

  it "can nav to the shelter's pets from the shelter show" do
    visit "/shelters/#{@shelter_1.id}"
    click_link "View Pets at #{@shelter_1.name}"

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/pets")
  end
end
