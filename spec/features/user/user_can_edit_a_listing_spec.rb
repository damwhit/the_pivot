require "rails_helper"

RSpec.feature "UserEditsListingForAnEvent", type: :feature do
  include SpecHelpers
  scenario "user edits a listing", js: true do
    make_listings_and_tickets
    user = User.first
    listing = Listing.last

    visit "/"

    click_on "sign in"
    fill_in "email", with: user.email
    fill_in "password", with: "password"

    click_on "login"

    click_on "my listings"

    expect(page).to have_content("Sun Festival")
    within("#listing-4") do
      fill_in "price", with: "1000"
      fill_in "row", with: "5"
      fill_in "seat_number_1", with: "1"
      click_on "add seat"

      fill_in "seat_number_2", with: "11"

      click_on "add seat"

      fill_in "seat_number_3", with: "12"

      click_on "remove_1"
      click_on "update listing"
    end

    expect(current_path).to eq("/dashboard")

    within(".table-listings") do
      expect(page).to have_content("$16.00")
      expect(page).to_not have_content("$3.00")
      expect(page).to have_content(listing.format_date.to_s)
      expect(page).to have_content("active")
    end
    within".alert" do
      expect(page).to have_content("Listing number 4 has been updated!")
    end
  end
end
