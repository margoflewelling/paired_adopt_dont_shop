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
    visit "/favorite"
    expect(page).to_not have_content(@pet_1.name)
    visit "/pets/#{@pet_1.id}"
    click_button 'Favorite'

    visit "/favorite"
    within ".pet-#{@pet_1.id}" do
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_css("img[src='#{@pet_1.image}']")
    end

    click_link("#{@pet_1.name}")
    expect(page).to have_current_path("/pets/#{@pet_1.id}")
  end

  it "can only favorite a pet once" do
    visit "/pets/#{@pet_1.id}"
    click_button "Favorite"
    page.refresh
    expect(page).to_not have_button("Favorite")
    click_button "Unfavorite"
    expect(page).to have_current_path("/pets/#{@pet_1.id}")
    expect(page).to have_content("#{@pet_1.name} has been removed from your favorites")
    page.refresh
    expect(page).to have_button("Favorite")
    within ".favorite" do
      expect(page).to have_content("0")
    end
  end

  it "can delete favorites from the favorite index page" do
    visit "/pets/#{@pet_1.id}"
    click_button "Favorite"
    visit "/favorite"

    expect(page).to have_content("My Favorites: 1")

    within ".pet-#{@pet_1.id}" do
      click_button "Unfavorite"
    end

    expect(page).to have_current_path("/favorite")
    expect(page).to_not have_css(".pet-#{@pet_1.id}")
    expect(page).to have_content("#{@pet_1.name} has been removed from your favorites")
    expect(page).to have_content("My Favorites: 0")
  end

  it "can be told it has no favorites when it has not favorited" do
    visit "/favorite"

    expect(page).to have_content("You have not selected any pets as favorites.")
  end

  it "can bulk unfavorite all pets" do
    visit "/pets/#{@pet_1.id}"
    click_button "Favorite"
    visit "/pets/#{@pet_2.id}"
    click_button "Favorite"
    visit "/favorite"

    expect(page).to have_css(".pet-#{@pet_1.id}")
    expect(page).to have_css(".pet-#{@pet_2.id}")

    click_button "Remove All Favorites"

    expect(page).to_not have_css(".pet-#{@pet_1.id}")
    expect(page).to_not have_css(".pet-#{@pet_2.id}")
  end

  it "can see all pets with pending applications" do
    visit "/pets/#{@pet_1.id}"
    click_button "Favorite"

    visit "/pets/#{@pet_2.id}"
    click_button "Favorite"
    application_1 = Application.create( name: "Andy",
                                          address: "123 Main St",
                                          city: "Denver",
                                          state: "CO",
                                          zip: "80220",
                                          phone_number: "123-456-7890",
                                          description: "I can has dogs.")
    PetApplication.create(  pet_id: @pet_1.id,
                            application_id: application_1.id)

    visit "/favorite"

    within "#pending_applications" do
      expect(page).to have_link("#{@pet_1.name}")
      expect(page).to_not have_link("#{@pet_2.name}")
    end
    save_and_open_page
  end

end
