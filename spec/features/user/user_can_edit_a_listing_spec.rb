require "rails_helper"

RSpec.feature "UserAddsListingForAnEvent", type: :feature do
  include SpecHelpers
  scenario "user edits a listing", js: true do
    make_listings_and_tickets
    user = User.first
    listing = Listing.first

    visit "/"

    click_on "sign in"
    fill_in "email", with: user.email
    fill_in "password", with: "password"

    click_on "login"

    click_on "my listings"

    expect(page).to have_content("Sun Festival")
    save_and_open_page
    within("#listing-1") do
      fill_in "price", with: "10"
      fill_in "row", with: "5"

      click_on "update listing"
    end

    expect(current_path).to eq("/dashboard")

    within(".table-listings") do
      expect(page).to have_content("$1000.00")
      expect(page).to have_content(listing.format_date.to_s)
      expect(page).to have_content("upcoming")
    end
    within".alert" do
      expect(page).to have_content("Your listing has been updated!")
    end

  end
# As a logged in user
# When I visit ‘/users/:user_id/dashboard’
# And click on ‘My listings’
# my current page should be '/user/:user_id/listings'
# I see all listings paginated and ordered by closest to current date.
# I fill in the ticket info Row, seat number and the price for the listing I would like to edit.
# And I click on "edit listing" next to the listing that I want to edit.
# I should see 'Your listing#{name} has been updated!'
# And I should see not see the updated listing info on my dashboard
# And I should not see the non-updated info on my dashboard
end
