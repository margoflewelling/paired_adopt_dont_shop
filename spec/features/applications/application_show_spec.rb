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
    @application_2 = Application.create( name: "Margo",
                                          address: "123 S St",
                                          city: "Denver",
                                          state: "CO",
                                          zip: "80210",
                                          phone_number: "123-456-7890",
                                          description: "I lub dogs.")

    @pet_application_1 = PetApplication.create(  pet_id: @pet_1.id,
                                                  application_id: @application_1.id)
    @pet_application_2 = PetApplication.create(  pet_id: @pet_2.id,
                                                  application_id: @application_1.id)
    @pet_application_3 = PetApplication.create(  pet_id: @pet_1.id,
                                                  application_id: @application_2.id)

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
    click_link "#{@pet_2.name}"
    expect(page).to have_current_path("/pets/#{@pet_2.id}")
  end

  it "can approve an application" do
    visit "/applications/#{@application_1.id}"
    within("##{@pet_1.id}") do
      click_link "Approve application for #{@pet_1.name}"
    end
    expect(page).to have_current_path("/pets/#{@pet_1.id}")
    expect(page).to have_content("Pending Adoption")
    expect(page).to have_content("On hold for #{@application_1.name}")
  end

  it "can approve a user for more than one pet" do
    visit "/applications/#{@application_1.id}"
    within ("##{@pet_1.id}") do
      click_link "Approve application for #{@pet_1.name}"
    end
    expect(page).to have_content("Pending Adoption")
    expect(page).to have_content("On hold for #{@application_1.name}")

    visit "/applications/#{@application_1.id}"
    within ("##{@pet_2.id}") do
      click_link "Approve application for #{@pet_2.name}"
    end
    expect(page).to have_content("Pending Adoption")
    expect(page).to have_content("On hold for #{@application_1.name}")
  end

  it "pet can only have one approved application" do
    visit "/applications/#{@application_1.id}"
    within ("##{@pet_1.id}") do
      click_link "Approve application for #{@pet_1.name}"
    end
    visit "/applications/#{@application_2.id}"
    within ("##{@pet_1.id}") do
      expect(page).to_not have_link("Approve application for #{@pet_1.name}")
    end
  end

  it "can revoke an approved application" do
    visit "/applications/#{@application_1.id}"
    within ("##{@pet_1.id}") do
      click_link "Approve application for #{@pet_1.name}"
    end
    visit "/applications/#{@application_1.id}"
    expect(page).to have_link("Unapprove application for #{@pet_1.name}")

    click_link "Unapprove application for #{@pet_1.name}"

    expect(page).to have_current_path("/applications/#{@application_1.id}")
    expect(page).to have_link("Approve application for #{@pet_1.name}")

    visit "/pets/#{@pet_1.id}"

    expect(page).to have_content("Adoption Status: Adoptable")
    expect(page).to_not have_content("On hold for")
  end

  it "can not delete a shelter that has pets with pending applications" do
    visit "/applications/#{@application_1.id}"
    within ("##{@pet_1.id}") do
      click_link "Approve application for #{@pet_1.name}"
    end
    visit "/shelters/#{@shelter_1.id}"
    expect(page).to_not have_link("Delete Shelter")
    visit "/shelters"
    within ("##{@shelter_1.id}") do
      expect(page).to_not have_link("Delete Shelter")
    end
  end

  it "can delete and shelter as long as no pets are pending, and all pets get deleted" do
    visit "/shelters/#{@shelter_1.id}"
    click_link "Delete Shelter"
    visit "/pets"
    expect(page).to_not have_content(@pet_1.name)
    visit "/shelters"
    expect(page).to_not have_content(@shelter_1.name)
  end



end
