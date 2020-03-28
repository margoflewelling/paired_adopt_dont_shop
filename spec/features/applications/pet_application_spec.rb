require 'rails_helper'

RSpec.describe "Application page - As a user", type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create( name: "Henry Porter's Puppies",
                                address: "1315 Monaco Parkway",
                                city: "Denver",
                                state: "CO",
                                zip: "80220")

    @shelter_2 = Shelter.create( name: "Holly's Homeless Animals",
                                address: "55400 Township Rd 456",
                                city: "Coshocton",
                                state: "OH",
                                zip: "43812")
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


    visit "/pets/#{@pet_1.id}"
    click_button "Favorite"

    visit "/pets/#{@pet_2.id}"
    click_button "Favorite"
end

it "can see an adoption application " do
visit "/favorite"
click_link "Adoption Application"
expect(page).to have_current_path("/applications/new")
expect(page).to have_content(@pet_1.name)
expect(page).to have_content(@pet_2.name)
check "#{@pet_1.id}"
check "#{@pet_2.id}"
fill_in(:name, :with => "Margo")
fill_in(:address, :with => "1662 S Pearl S")
fill_in(:city, :with => "Denver")
fill_in(:state, :with => "CO")
fill_in(:zip, :with => "80210")
fill_in(:phone_number, :with => "394-111-1111")
fill_in(:description, :with => "I love dogs")
click_button "Submit Application"
expect(page).to have_content("Your application has been processed for #{@pet_1.name}, #{@pet_2.name}")
expect(page).to have_current_path("/favorite")
within "content" do
expect(page).to_not have_content(@pet_1.name)
expect(page).to_not have_content(@pet_2.name)
end 
end

end
