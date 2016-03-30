require "rails_helper"
RSpec.feature "UserRemovesLIsting", type: :feature do
  include SpecHelpers
  scenario "user removes a listing" do
    make_listings_and_tickets
    user = User.first

    visit "/"

    click_on "sign in"
    fill_in "email", with: user.email
    fill_in "password", with: "password"

    click_on "login"

    click_on "my listings"

    expect(page).to have_content("Listing #: 1")

    within("#listing-1") do
      click_on "remove listing"
    end

    within".alert" do
      expect(page).to have_content("Listing 1 has been cancelled")
    end

    click_on "my listings"

    expect(page).to_not have_content("$8")
    expect(page).to_not have_content("listing #1")

    within("#listing-3") do
      click_on "remove listing"
    end

    within".alert" do
      expect(page).to have_content("Listing 3 has been deactivated")
    end

    click_on "my listings"
    require "pry"; binding.pry
  end
end
