require 'rails_helper'

RSpec.describe "Reviews index page - As a user", type: :feature do
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

    @review_1 = Review.create(title: "Found my forever friend!",
                              rating: "5 stars",
                              content: "They have great volunteers & staff at Henry's, adopted my first dog here!",
                              image: "https://cdn.theatlantic.com/thumbor/pN25nhF1hatn7QpckNtABKwzmoI=/0x61:1000x624/720x405/media/old_wire/img/upload/2013/03/18/happydog/original.jpg",
                              shelter_id: @shelter_1.id)
    @review_2 = Review.create(title: "Excellent!",
                              rating: "Would recommend",
                              content: "They always have the best selection of dogs here!",
                              shelter_id: @shelter_2.id)


  end

  it "can see all the reviews for a shelter" do
    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content (@review_1.title)
    expect(page).to have_content (@review_1.rating)
    expect(page).to have_content (@review_1.content)
    # expect(page).to have_css("img[src='/assets/hp-606612a36d3cc16d901e74616fbd73a568030910d171797aa44123d55a9bfa70.jpg']")

    expect(page).to_not have_content (@review_2.title)
    expect(page).to_not have_content (@review_2.rating)

  end
end
