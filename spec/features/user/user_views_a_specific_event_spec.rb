require "rails_helper"

RSpec.feature "UserViewsASpecificEvent", type: :feature do
  include SpecHelpers
  scenario "user views a specific event" do
    event = event1

    listing_1 = listing1
    listing_2 = listing2

    visit "/festivals"

    within(".event-name") do
      click_on "Sun Festival"
    end
    # is database cleaner not working?

    visit "/events/#{event.id}"

    #expect(current_path).to eq(event_path(event))

    #can we not use AWS for specs?

    expect(page).to have_content(event.format_time)
    expect(page).to have_content(event.venue.city)
    #expect(page).to have_content(listing_1.ticket.price)
    #expect(page).to have_content(listing_1.ticket.seat)
    #expect(page).to have_content(listing_2.ticket.price)
    #expect(page).to have_content(listing_2.ticket.seat)
  end
end

# As a visitor
# When I visit ‘/category_name’
# And click on a event title
# I will see the time and location of the event
# And see all the tickets on sale for the event
