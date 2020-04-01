require 'rails_helper'

describe Pet, type: :model do
  describe "relationships" do
    it {should belong_to :shelter}
    it {should have_many :pet_applications}
    it {should have_many :applications}
  end

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :sex}
    it {should validate_presence_of :description}
    it {should validate_presence_of :image}
  end

  describe "model methods" do
    it "- A pet knows its shelter" do
      shelter_1 = Shelter.create( name: "Henry Porter's Puppies",
                                  address: "1315 Monaco Parkway",
                                  city: "Denver",
                                  state: "CO",
                                  zip: "80220"
                                )
      pet_1 = Pet.create( name: "Henry",
                          age: 4,
                          sex: "Male",
                          shelter_id: shelter_1.id,
                          image: 'hp.jpg')

      expect(pet_1.shelter_name).to eq("Henry Porter's Puppies")
    end
  end

  describe '#application lookup' do
    it 'can find accepted application by pet' do
      shelter_1 = Shelter.create( name: "Henry Porter's Puppies",
                                  address: "1315 Monaco Parkway",
                                  city: "Denver",
                                  state: "CO",
                                  zip: "80220"
                                )
      application_1 = Application.create( name: "Andy",
                                            address: "123 Main St",
                                            city: "Denver",
                                            state: "CO",
                                            zip: "80220",
                                            phone_number: "123-456-7890",
                                            description: "I can has dogs.")

      pet_1 = Pet.create( name: "Henry",
                          age: 4,
                          sex: "Male",
                          shelter_id: shelter_1.id,
                          image: 'hp.jpg',
                          adoptable_status: "Adoptable",
                          accepted_app_id: application_1.id,
                          description: "great")
      pet_application_1 = PetApplication.create(  pet_id: pet_1.id,
                                                  application_id: application_1.id)

    expect(pet_1.application_lookup(pet_1)).to eq(application_1)

  end
end


end
