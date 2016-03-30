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

    click_on "cart"

    expect(Ticket.find(1).status).to eq("reserved")

    click_on "Checkout"

    fill_in "name", with: user.name
    fill_in "email", with: user.email
    fill_in "password", with: user.password

    click_on "continue"

    expect(page).to have_content("sorry, you cannot purchase tickets :(")

    expect(page).to have_content("cart(0)")

    expect(Ticket.find(1).status).to eq("active")
  end
end
