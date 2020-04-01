require 'rails_helper'

describe Shelter, type: :model do
  describe "relationships" do
    it {should have_many :pets}
    it {should have_many :reviews}
  end

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe "model methods" do
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
                          adoptable_status: 'Pending Adoption')
      @pet_3 = Pet.create( name: "Feather",
                          age: 5,
                          sex: "Female",
                          shelter_id: @shelter_1.id,
                          image: 'hp2.jpg',
                          description: 'Cute',
                          adoptable_status: 'Adoptable')
      @pet_4 = Pet.create( name: "Belle",
                          age: 5,
                          sex: "Female",
                          shelter_id: @shelter_1.id,
                          image: 'hp2.jpg',
                          description: 'Cute',
                          adoptable_status: 'Adopted')
    end
    it "- A shelter has adoptable pets" do
      expect(@shelter_1.adoptable_pets).to include(@pet_1)
      expect(@shelter_1.adoptable_pets).to include(@pet_3)
      expect(@shelter_1.adoptable_pets).not_to include(@pet_2)
      expect(@shelter_1.adoptable_pets).not_to include(@pet_4)

    end

    it "- A shelter has pets pending adoption" do
      expect(@shelter_1.pending_pets).not_to include(@pet_1)
      expect(@shelter_1.pending_pets).not_to include(@pet_3)
      expect(@shelter_1.adoptable_pets).not_to include(@pet_4)
      expect(@shelter_1.pending_pets).to include(@pet_2)
    end

    it "- Calculates pet count" do
      expect(@shelter_1.pet_count).to eq(3)
    end

    it "- Calculates application count" do
      application_1 = Application.create( name: "Andy",
                                            address: "123 Main St",
                                            city: "Denver",
                                            state: "CO",
                                            zip: "80220",
                                            phone_number: "123-456-7890",
                                            description: "I can has dogs.")
      PetApplication.create(  pet_id: @pet_1.id,
                              application_id: application_1.id)

      expect(@shelter_1.application_count).to eq(1)
    end

    it "- Calculates average rating" do
      Review.create!(title: "Found my forever friend!",
                                rating: 5,
                                content: "They have great volunteers & staff at Henry's, adopted my first dog here!",
                                image: "https://cdn.theatlantic.com/thumbor/pN25nhF1hatn7QpckNtABKwzmoI=/0x61:1000x624/720x405/media/old_wire/img/upload/2013/03/18/happydog/original.jpg",
                                shelter_id: @shelter_1.id)
      Review.create!(title: "Excellent!",
                                rating: 4,
                                content: "They always have the best selection of dogs here!",
                                shelter_id: @shelter_1.id)

      expect(@shelter_1.average_rating).to eq(4.5)
    end
  end
end
