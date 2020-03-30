require 'rails_helper'

RSpec.describe "SHELTERS show page - A user", type: :feature do
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
    @pet_2 = Pet.create( name: "Liza",
                        age: 16,
                        sex: "Female",
                        shelter_id: @shelter_1.id,
                        image: 'hp2.jpg',
                        description: 'Cute',
                        adoptable_status: 'Adoptable')
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

  it 'can not update without all information' do
    visit "/shelters/#{@shelter_1.id}"
    click_link "Update Shelter"
    fill_in('zip', :with => nil)
    click_button "Update Shelter"
    expect(page).to have_content("You need to complete the zip information")
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

  it "can see shelter statistics" do
    Review.create!(title: "Found my forever friend!",
                              rating: "5",
                              content: "They have great volunteers & staff at Henry's, adopted my first dog here!",
                              image: "https://cdn.theatlantic.com/thumbor/pN25nhF1hatn7QpckNtABKwzmoI=/0x61:1000x624/720x405/media/old_wire/img/upload/2013/03/18/happydog/original.jpg",
                              shelter_id: @shelter_1.id)
    Review.create!(title: "Excellent!",
                              rating: "1",
                              content: "They always have the best selection of dogs here!",
                              shelter_id: @shelter_1.id)

    application_1 = Application.create( name: "Andy",
                                          address: "123 Main St",
                                          city: "Denver",
                                          state: "CO",
                                          zip: "80220",
                                          phone_number: "123-456-7890",
                                          description: "I can has dogs.")
    PetApplication.create(  pet_id: @pet_1.id,
                            application_id: application_1.id)
    PetApplication.create(  pet_id: @pet_2.id,
                            application_id: application_1.id)

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content("Number of pets living at this shelter: 2")
    # expect(page).to have_content("Average rating of this shelter: 3")
    expect(page).to have_content("Number of applications on file at this shelter: 2")
  end
end
