require "rails_helper"

RSpec.feature "UserViewsASpecificEvent", type: :feature do
  include SpecHelpers
  scenario "user views a specific event" do
    event = event1

    listing_1 = listing1
    listing_2 = listing2

    ticket_1 = ticket1.update(row: "5", seat: "8", price: 900)
    ticket_2 = ticket2.update(row: "5", seat: "9", price: 900)
    ticket_3 = ticket3.update(row: "7", seat: "3", price: 1000)

    visit "/festivals"

    within(".event-name") do
      click_on "Sun Festival"
    end

    expect(current_path).to eq(event_path(event))

    expect(page).to have_content(event.format_time)
    expect(page).to have_content(event.venue.city)

    within("#listing-#{listing_1.id}") do
      expect(page).to have_content("price: $9")
      expect(page).to have_content("row: 5")
      expect(page).to have_content("quantity: 2")
    end

    within("#listing-#{listing_2.id}") do
      expect(page).to have_content("row: 7")
      expect(page).to have_content("price: $10")
      expect(page).to have_content("quantity: 1")
    end
  end
end
