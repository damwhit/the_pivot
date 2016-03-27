require "rails_helper"

RSpec.feature "UserViewsASpecificEvent", type: :feature do
  include SpecHelpers
  scenario "user views a specific event" do
    event = event1
    user_1 = user1
    user_2 = user2

    listing_1 = event1.listings.new(user_id: user_1.id)
    listing_1.tickets << Ticket.new(price: 900, seat: "8", row: "5")
    listing_1.tickets << Ticket.new(price: 900, seat: "9", row: "5")
    listing_1.save

    listing_2 = event1.listings.new(user_id: user_2.id)
    listing_2.tickets << Ticket.new(price: 1000, seat: "3", row: "7")
    listing_2.save

    visit "/festivals"

    within(".event-name") do
      click_on "Sun Festival"
    end

    expect(current_path).to eq(event_path(event))

    expect(page).to have_content(event.format_time)
    expect(page).to have_content(event.venue.city)

    within("#listing-#{listing_1.id}") do
      expect(page).to have_content("row: 5")
      expect(page).to have_content("price: $9")
      expect(page).to have_content("quantity: 2")
      expect(page).to_not have_content("row: 7")
    end

    within("#listing-#{listing_2.id}") do
      expect(page).to have_content("row: 7")
      expect(page).to have_content("price: $10")
      expect(page).to have_content("quantity: 1")
      expect(page).to_not have_content("row: 5")
    end
  end

  scenario "user can only view active tickets" do
    event = event1
    listing = listing1

    ticket1.update(seat: "8")
    ticket2.update(seat: "9", status: "inactive")

    visit event_path(event)

    within("#listing-#{listing.id}") do
      expect(page).to have_content("8")
      expect(page).to_not have_content("9")
    end
  end
end
