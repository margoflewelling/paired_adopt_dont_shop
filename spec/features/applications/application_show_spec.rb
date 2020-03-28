require 'rails_helper'

RSpec.describe "Application show page - As a user", type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create( name: "Henry Porter's Puppies",
                                address: "1315 Monaco Parkway",
                                city: "Denver",
                                state: "CO",
                                zip: "80220")
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
    @application_1 = Application.create( name: "Andy",
                                          address: "123 Main St",
                                          city: "Denver",
                                          state: "CO",
                                          zip: "80220",
                                          phone_number: "123-456-7890",
                                          description: "I can has dogs.")
    @pet_application_1 = PetApplication.create(  pet_id: @pet_1.id,
                                                  application_id: @application_1.id)
    @pet_application_2 = PetApplication.create(  pet_id: @pet_2.id,
                                                  application_id: @application_1.id)
  end

  it "can see pet applications" do
    visit "/applications/#{@application_1.id}"
    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.phone_number)
    expect(page).to have_content(@application_1.zip)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    save_and_open_page
    click_link "#{@pet_2.name}"
    expect(page).to have_current_path("/pets/#{@pet_2.id}")
  end
end
