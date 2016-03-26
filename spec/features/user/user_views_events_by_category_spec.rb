require "rails_helper"

RSpec.feature "UserViewsEventsByCategory", type: :feature do
  include SpecHelpers
  scenario "user views events by category" do
    category1
    event1 = make_events[:event1]
    event2 = make_events[:event2]
    event3 = make_events[:event3]

    visit "/festivals"

    # add css image

    expect(page).to have_content(event1.name)
    expect(page).to have_content(event1.venue.city)
    expect(page).to have_content(event1.format_date)
    expect(page).to have_content(event1.format_time)
    expect(page).to have_content(event2.name)
    expect(page).to have_content(event2.venue.city)
    expect(page).to_not have_content(event3.name)
  end
end
