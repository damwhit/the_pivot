require "rails_helper"

RSpec.feature "SuspendedUserCannotPurchaseTickets", type: :feature do
  include SpecHelpers
  scenario "user with suspended status cannot purchase tickets" do
    make_listings_and_tickets

    user = suspended_user

    event = Event.last
    listing = Listing.first

    visit event_path(event)

    within("#listing-#{listing.id}") do
      select "10", from: "seats"
      click_on "add to cart!"
    end

    expect(current_path).to eq("/#{event.category.name}")

    expect(page).to have_content("listing number #{listing.id} added to cart!")

    click_on "cart"

    click_on "Checkout"

    fill_in "name", with: user.name
    fill_in "email", with: user.email
    fill_in "password", with: user.password

    click_on "continue"

    expect(page).to have_content("sorry, you cannot purchase tickets :(")
  end
end
