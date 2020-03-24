require 'rails_helper'

RSpec.describe "SHELTERS new page - A user", type: :feature do
  it "can create new shelter" do
    visit "/shelters/new"
    fill_in('Name', :with => "Holly's Homeless Animals")
    fill_in('Address', :with => '55400 Twp Rd 456')
    fill_in('City', :with => 'Coshocton')
    fill_in('State', :with => 'OH')
    fill_in('Zip', :with => '43812')
    click_button('Create Shelter')

    expect(page).to have_content("Holly's Homeless Animals")
    expect(page).to have_content("55400 Twp Rd 456")
    expect(page).to have_content("Coshocton")
    expect(page).to have_content("OH")
    expect(page).to have_content("43812")
  end
end
