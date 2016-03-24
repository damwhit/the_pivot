require "rails_helper"

RSpec.feature "UserViewsASpecificEvent", type: :feature do
  scenario "user views a specific event" do
    pending
    event = event

    listing1 = listing1
    listing2 = listing2

    visit "/festivals"

    click_on "Sun Festival"

    expect(current_path).to eq(event_path(event))

    expect(page).to have_content(event.time)
    expect(page).to have_content(event.venue.city)
    expect(page).to have_content(listing1.price)
    expect(page).to have_content(listing1.seat)
    expect(page).to have_content(listing2.price)
    expect(page).to have_content(listing2.seat)
  end
end

# As a visitor
# When I visit ‘/category_name’
# And click on a event title
# I will see the time and location of the event
# And see all the tickets on sale for the event
