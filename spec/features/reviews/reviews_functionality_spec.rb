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

    @review_1 = Review.create!(title: "Found my forever friend!",
                              rating: 5,
                              content: "They have great volunteers & staff at Henry's, adopted my first dog here!",
                              image: "https://cdn.theatlantic.com/thumbor/pN25nhF1hatn7QpckNtABKwzmoI=/0x61:1000x624/720x405/media/old_wire/img/upload/2013/03/18/happydog/original.jpg",
                              shelter_id: @shelter_1.id)
    @review_2 = Review.create!(title: "Excellent!",
                              rating: 4,
                              content: "They always have the best selection of dogs here!",
                              shelter_id: @shelter_2.id)


  end

  it "can see all the reviews for a shelter" do
    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content (@review_1.title)
    expect(page).to have_content (@review_1.rating)
    expect(page).to have_content (@review_1.content)
    expect(page).to have_css("img[src='#{@review_1.image}']")

    expect(page).to_not have_content (@review_2.title)
    expect(page).to_not have_content (@review_2.content)
  end

  it "can add a new review for a shelter" do
    visit "/shelters/#{@shelter_1.id}"

    click_link "Add New Review"
    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/review/new")

    fill_in('title', :with => "Andy's Test Review")
    select "3", :from => "rating"
    fill_in('content', :with => "Lorem Ipsum dog stuff")
    fill_in('image', :with => "https://cdn.theatlantic.com/thumbor/pN25nhF1hatn7QpckNtABKwzmoI=/0x61:1000x624/720x405/media/old_wire/img/upload/2013/03/18/happydog/original.jpg")
    click_button "Save Review"
    expect(page).to have_current_path("/shelters/#{@shelter_1.id}")
    expect(page).to have_content ("Andy's Test Review")
    expect(page).to have_content ("Rating: 3")
    expect(page).to have_content ("Lorem Ipsum dog stuff")
  end

  it 'can edit a review for a shelter' do
    visit "shelters/#{@shelter_1.id}"
    click_link "Edit Review"
    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/#{@review_1.id}/edit")
    select "3", :from => "rating"
    click_on "Save Review"
    within "#Review-#{@review_1.id}" do
      expect(page).to have_current_path("/shelters/#{@shelter_1.id}")
      expect(page).to have_content ("Rating: 3")
      expect(page).to_not have_content("Rating: 5")
    end
  end

  it 'can delete a review for a shelter' do
    visit "shelters/#{@shelter_1.id}"
    click_link "Delete Review"
    expect(page).to_not have_content (@review_1.title)
    expect(page).to_not have_content (@review_1.content)
  end

  it 'shows a flash message for incomplete fields on creation' do
    visit "shelters/#{@shelter_1.id}"
    click_link "Add New Review"

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/review/new")

    click_button "Save Review"

    expect(page).to have_content ("Please enter a title, rating, and content")
    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/review/new")
  end

  it 'shows a flash message for incomplete fields on editing' do
    visit "shelters/#{@shelter_1.id}"
    click_link "Edit Review"

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/#{@review_1.id}/edit")
    fill_in('content', :with => '')
    click_button "Save Review"

    expect(page).to have_content ("Please enter a title, rating, and content")
    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/#{@review_1.id}/edit")
  end

  it "deletes a shelters reviews when a shelter is deleted" do
    visit "shelters/#{@shelter_1.id}"
    expect {click_on "Delete Shelter" }.to change(Review, :count).by(-1)
  end

  it "defaults to an image if one is not provided" do
    visit "shelters/#{@shelter_2.id}"

    within "#Review-#{@review_2.id}" do
      expect(page).to have_css("img[src='#{@review_2.image}']")
    end
  end

end
