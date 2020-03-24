require 'rails_helper'

RSpec.describe "PETS index page - A user", type: :feature do
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

  it "can see the name and info of each pet in the system" do

    visit "/pets"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_1.age)
    expect(page).to have_content(@pet_2.age)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content(@pet_2.sex)
    expect(page).to have_css("img[src='/assets/hp-606612a36d3cc16d901e74616fbd73a568030910d171797aa44123d55a9bfa70.jpg']")
    expect(page).to have_css("img[src='/assets/hp2-d54ec5938e641f10459be7bdba8fbb7fed849ec44ba2d1ed8568773d69bd164d.jpg']")
  end

  it "can click to edit an existing pet" do
    visit "/pets"
    within("##{@pet_1.id}") do
      click_link "Edit Pet"
    end

    expect(page).to have_current_path("/pets/#{@pet_1.id}/edit")

    visit "/pets"
    within("##{@pet_2.id}") do
      click_link "Edit Pet"
    end

    expect(page).to have_current_path("/pets/#{@pet_2.id}/edit")
  end

  it "can click to delete an existing pet" do
    visit "/pets"
    within("##{@pet_1.id}") do
      click_link "Delete Pet"
    end

    expect(page).to have_current_path("/pets")
    expect(page).not_to have_content(@pet_1.name)

    visit "/pets"
    within("##{@pet_2.id}") do
      click_link "Delete Pet"
    end

    expect(page).to have_current_path("/pets")
    expect(page).not_to have_content(@pet_2.name)
  end

  it "can click to show the shelter", type: :feature do
    visit "/pets"
    within("##{@pet_1.id}") do
      click_link "#{@pet_1.shelter_name}"
    end

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}")

    visit "/pets"
    within("##{@pet_2.id}") do
      click_link "#{@pet_2.shelter_name}"
    end

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}")
  end

  it "can click to show the pet" do
    visit "/pets"
    within("##{@pet_1.id}") do
      click_link "#{@pet_1.name}"
    end

    expect(page).to have_current_path("/pets/#{@pet_1.id}")

    visit "/pets"
    within("##{@pet_2.id}") do
      click_link "#{@pet_2.name}"
    end

    expect(page).to have_current_path("/pets/#{@pet_2.id}")
  end
end
