require "rails_helper"

RSpec.feature "UserViewsASpecificEvent", type: :feature do
  include SpecHelpers
  scenario "user views a specific event" do
    make_listings_and_tickets

    event = Event.last
    listing1 = Listing.first
    listing2 = Listing.last

    visit "/festivals"

    within(".event-name") do
      click_on "Sun Festival"
    end

    expect(current_path).to eq(event_path(event))

    expect(page).to have_content(event.format_time)
    expect(page).to have_content(event.venue.city)

    within("#listing-#{listing1.id}") do
      expect(page).to have_content("row: 5")
      expect(page).to have_content("price: $8")
      expect(page).to have_content("quantity: 2")
      expect(page).to_not have_content("row: 1")
    end

    within("#listing-#{listing2.id}") do
      expect(page).to have_content("row: 1")
      expect(page).to have_content("price: $10")
      expect(page).to have_content("quantity: 1")
      expect(page).to_not have_content("row: 5")
    end
  end

  scenario "user can only view active tickets" do
    make_listing
    event = Event.last

    listing = Listing.last

    Ticket.first.update(seat: "8")
    Ticket.last.update(seat: "9", status: "inactive")

    visit event_path(event)

    within("#listing-#{listing.id}") do
      expect(page).to have_content("8")
      expect(page).to_not have_content("9")
    end
  end

  scenario "a listing disappears if all the tickets are bought" do
    make_listing

    user = User.last

    listing = Listing.last

    event = Event.last

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit event_path(event)

    expect(page).to have_css("#listing-#{listing.id}")

    order = user.orders.create(street: "1600 pennslyvania",
                               city: "washington",
                               state: "District of Columbia",
                               zip: "46250",
                               fullname: "jonathon adams",
                               first_name: "jonathon",
                               last_name: "adams",
                               email: "spam@foundingfathers.biz")

    order.tickets << Ticket.find_by(seat: "10")
    order.tickets << Ticket.find_by(seat: "11")

    order.set_ticket_status

    visit event_path(event)

    expect(page).to_not have_css("#listing-#{listing.id}")
  end
end
