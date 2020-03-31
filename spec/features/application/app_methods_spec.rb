require 'rails_helper'

RSpec.describe "#pet_id_lookup", type: :feature do
  it 'can find a pet object from an id' do

    shelter_1 = Shelter.create( name: "Henry Porter's Puppies",
                                address: "1315 Monaco Parkway",
                                city: "Denver",
                                state: "CO",
                                zip: "80220")

    pet_1 = Pet.create( name: "Holly",
                        age: 4,
                        sex: "Male",
                        shelter_id: shelter_1.id,
                        image: 'hp.jpg',
                        description: 'Cute',
                        adoptable_status: 'Adoptable')

    visit '/shelters'
    ac = ApplicationController.new
    expect(ac.pet_id_lookup(pet_1.id)).to eq(pet_1)
  end
end
