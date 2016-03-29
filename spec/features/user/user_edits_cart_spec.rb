require "rails_helper"

RSpec.feature "UserEditsCart", type: :feature do
  include SpecHelpers
  scenario "they remove a ticket from the cart and the ticket is not longer there" do
    make_listings_and_tickets

    event = Event.last
    listing = Listing.first
    ticket = Ticket.first

    visit event_path(event)

    within("#listing-#{listing.id}") do
      select "10", from: "seats"
      select "11", from: "seats"
      click_on "add to cart!"
    end

    visit "/cart"

    expect(Ticket.find(ticket.id).status).to eq("reserved")

    expect(page).to have_content("seat: #{ticket.seat}")

    within("#ticket-#{ticket.id}") do
      click_on "remove from cart"
    end

    expect(page).to_not have_content("seat #{ticket.seat}")

    expect(ticket.status).to eq("active")
  end
end
