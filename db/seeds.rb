# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Shelter.destroy_all
Review.destroy_all

#shelters

shelter_1 = Shelter.create( name: "Henry Porter's Puppies",
                            address: "1315 Monaco Parkway",
                            city: "Denver",
                            state: "CO",
                            zip: "80220"
                          )
shelter_2 = Shelter.create( name: "Holly's Homeless Animals",
                            address: "55400 Township Rd 456",
                            city: "Coshocton",
                            state: "OH",
                            zip: "43812"
                          )

#pets
pet_1 = Pet.create( name: "Karl Barx",
                    age: 4,
                    sex: "Male",
                    shelter_id: shelter_1.id,
                    image: 'hp.jpg',
                    adoptable_status: 'Adoptable',
                    description: "He's the cutest!")
pet_2 = Pet.create( name: "Liza Bear",
                    age: 16,
                    sex: "Female",
                    shelter_id: shelter_1.id,
                    image: 'hp2.jpg',
                    adoptable_status: 'Pending Adoption',
                    description: "Newfie drool!")

pet_3 = shelter_2.pets.create(name: "Dog Ross",
                              age: 5,
                              sex: "Male",
                              image: 'https://celebritypets.net/wp-content/uploads/2017/10/Halloween-dog-costume-dressup.png',
                              adoptable_status: 'Adoptable',
                              description: "Very independent and creative!")
pet_4 = shelter_2.pets.create(name: "Harold",
                              age: 1,
                              sex: "Male",
                              image: 'https://cdn.akc.org/content/hero/cute_puppies_hero.jpg',
                              adoptable_status: 'Pending Adoption',
                              description: "Young and energetic pup!")


#reviews

review_1 = Review.create!(title: "Found my forever friend!",
                          rating: "5 stars",
                          content: "They have great volunteers & staff at Henry's, adopted my first dog here!",
                          image: "https://cdn.theatlantic.com/thumbor/pN25nhF1hatn7QpckNtABKwzmoI=/0x61:1000x624/720x405/media/old_wire/img/upload/2013/03/18/happydog/original.jpg",
                          shelter_id: shelter_1.id)
review_2 = Review.create!(title: "Excellent!",
                          rating: "Would recommend",
                          content: "They always have the best selection of dogs here!",
                          shelter_id: shelter_2.id)
