require 'rails_helper'

RSpec.describe "SHOWPETS index page - A user", type: :feature do
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

    @pet_1 = Pet.create( name: "Karl Barx",
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
    @pet_3 = Pet.create( name: "Feather",
                        age: 5,
                        sex: "Female",
                        shelter_id: @shelter_2.id,
                        image: 'hp2.jpg',
                        description: 'Cute',
                        adoptable_status: 'Adoptable')
    @pet_4 = Pet.create( name: "Pepper Dog",
                        age: 15,
                        sex: "Male",
                        shelter_id: @shelter_1.id,
                        image: 'hp2.jpg',
                        description: 'Cute',
                        adoptable_status: 'Pending Adoption')
    @pet_5 = Pet.create( name: "Holly",
                        age: 6,
                        sex: "Male",
                        shelter_id: @shelter_1.id,
                        image: 'hp2.jpg',
                        description: 'Cute',
                        adoptable_status: 'Adopted')
  end
  it "can see the available pets" do
    visit "/shelters/#{@shelter_1.id}/pets"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_4.name)
    expect(page).to have_content(@pet_1.age)
    expect(page).to have_content(@pet_2.age)
    expect(page).to have_content(@pet_4.age)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content(@pet_2.sex)
    expect(page).to have_content(@pet_4.sex)
    expect(page).to have_css("img[src='/assets/hp-606612a36d3cc16d901e74616fbd73a568030910d171797aa44123d55a9bfa70.jpg']")
    expect(page).to have_css("img[src='/assets/hp2-d54ec5938e641f10459be7bdba8fbb7fed849ec44ba2d1ed8568773d69bd164d.jpg']")
    expect(page).to_not have_content(@pet_3.name)
    expect(page).to_not have_content(@pet_5.name)
  end

  it "can create a new pet" do
    visit "/shelters/#{@shelter_1.id}/pets"
    click_link "Create Pet"

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/pets/new")
  end

  it "can click to show the pet" do
    visit "/shelters/#{@shelter_1.id}/pets"
    within("##{@pet_1.id}") do
      click_link "#{@pet_1.name}"
    end

    expect(page).to have_current_path("/pets/#{@pet_1.id}")

    visit "/shelters/#{@shelter_2.id}/pets"
    within("##{@pet_3.id}") do
      click_link "#{@pet_3.name}"
    end

    expect(page).to have_current_path("/pets/#{@pet_3.id}")
  end

  it "can see the number of available pets" do
    visit "/shelters/#{@shelter_1.id}/pets"

    expect(page).to have_content("2 pets available")

    visit "/shelters/#{@shelter_2.id}/pets"

    expect(page).to have_content("1 pet available")
  end
end
