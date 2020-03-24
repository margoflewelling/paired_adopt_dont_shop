require 'rails_helper'

RSpec.describe "PETS new page - A user", type: :feature do
  it "can create a new pet" do
    shelter_1 = Shelter.create( name: "Henry Porter's Puppies",
                                address: "1315 Monaco Parkway",
                                city: "Denver",
                                state: "CO",
                                zip: "80220"
                              )

    visit "/shelters/#{shelter_1.id}/pets/new"

    fill_in(:name, :with => 'Karl Barx')
    fill_in(:age, :with => 5)
    fill_in(:sex, :with => 'Male')
    fill_in(:description, :with => 'Doggos of the world, unite!')
    fill_in(:image, :with => 'hp.jpg')
    click_button('Create Pet')

    expect(page).to have_current_path("/shelters/#{shelter_1.id}/pets")
    expect(page).to have_content("Karl Barx")
    expect(page).to have_css("img[src='/assets/hp-606612a36d3cc16d901e74616fbd73a568030910d171797aa44123d55a9bfa70.jpg']")
  end
end
