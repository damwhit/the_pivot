require "rails_helper"
RSpec.feature "UserRemovesListing", type: :feature do
  include SpecHelpers
  scenario "user removes a listing" do
    make_listings
    user = User.first

    @listing1 = Listing.first
    @listing3 = Listing.last

    visit "/"

    click_on "sign in"
    fill_in "email", with: user.email
    fill_in "password", with: "password"

    click_on "login"
    click_on "my listings"

    expect(page).to have_content("Listing #: #{@listing1.id}")
    expect(page).to have_content("Listing #: #{@listing3.id}")

    within("#listing-#{@listing1.id}") do
      click_on "remove listing"
    end

    within".alert" do
      expect(page).to have_content("Listing #{@listing1.id} has been cancelled")
    end

    click_on "my listings"

    expect(page).to_not have_content("$8")
    expect(page).to_not have_content("Listing #: #{@listing1.id}")

    within("#listing-#{@listing3.id}") do
      click_on "remove listing"
    end

    within".alert" do
      expect(page).to have_content("Listing #{@listing3.id} has been deactivated")
    end

    click_on "my listings"
    expect(page).to_not have_content("Listing #: #{@listing1.id}")
    expect(page).to have_content("Listing #: #{@listing3.id}")
  end
end
