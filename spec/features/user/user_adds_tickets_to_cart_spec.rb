require "rails_helper"

RSpec.feature "UserAddsTicketToCart", type: :feature do
  include SpecHelpers
  scenario "user adds Ticket to cart" do
    make_listings_and_tickets

    event = Event.last
    listing = Listing.first

    visit event_path(event)

    within("#listing-#{listing.id}") do
      select "10", from: "seats"
      select "11", from: "seats"
      click_on "add to cart!"
    end

    expect(current_path).to eq("/#{event.category.name}")

    expect(page).to have_content("listing number #{listing.id} added to cart!")

    click_on "cart"

    expect(current_path).to eq("/cart")

    expect(page).to have_content(event.name)
    expect(page).to have_content(listing.tickets.first.format_price)

    within(".cart-total") do
      expect(page).to have_content("$16")
    end
  end

  scenario "user does not choose a seat and is redirect to event show" do
    make_listings_and_tickets

    event = Event.last
    listing = Listing.first

    visit event_path(event)

    within("#listing-#{listing.id}") do
      click_on "add to cart!"
    end

    expect(page).to have_content("please select a seat")
  end

  scenario "user cannot add the same ticket twice" do
    make_listings_and_tickets

    event = Event.last
    listing = Listing.first
    ticket = Ticket.first

    visit event_path(event)

    within("#listing-#{listing.id}") do
      select "10", from: "seats"
      click_on "add to cart!"
    end

    expect(page).to have_content("listing number #{listing.id} added to cart!")

    visit event_path(event)

    within("#listing-#{listing.id}") do
      expect(page).to_not have_content(ticket.seat)
    end
  end
end
