require 'rails_helper'

RSpec.describe "WELCOME index page - A user", type: :feature do
  it "is re-routed to the the shelter index page" do
    visit "/"

    expect(page).to have_current_path("/shelters")
  end
end
