require "rails_helper"
RSpec.feature "UserRemovesLIsting", type: :feature do
  include SpecHelpers
  scenario "user removes a listing" do
    make_listings_and_tickets
    user = User.first
    listing = Listing.last

    visit "/"

    click_on "sign in"
    fill_in "email", with: user.email
    fill_in "password", with: "password"

    click_on "login"

    within(".table-listings") do
      expect(page).to have_content("$1600.00")
      expect(page).to have_content(listing.format_date.to_s)
      expect(page).to have_content("upcoming")
    end

    click_on "my listings"

    expect(page).to have_content("Sun Festival")
    within("#listing-2") do
      click_on "remove listing"
    end

    expect(current_path).to eq("/dashboard")
    within(".table-listings") do
      expect(page).to_not have_content("$1600.00")
      expect(page).to_not have_content(listing.format_date.to_s)
      expect(page).to_not have_content("upcoming")
    end

    within".alert" do
      expect(page).to have_content("Listing number 2 has removed")
    end
  end
end
