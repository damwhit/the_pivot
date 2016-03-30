require "rails_helper"

RSpec.feature "AdminCanCreateAnEvent", type: :feature do
  include SpecHelpers
  scenario "see event on index page and flash message" do
    create_and_stub_admin
    category2
    venue1
    date = Date.today + 25
    time = "07:00 PM"

    visit "/admin/dashboard"

    click_on "new event"
    expect(current_path).to eq("/admin/events/new")

    fill_in "name", with: "Curling: USA vs. Canada"
    select "Neat Ampitheatre", from: "event[venue_id]"
    fill_in "date", with: date.strftime("%m/%d/%Y")
    fill_in "time", with: time
    select "sports", from: "event[category_id]"
    fill_in "tags", with: "family, fringe"

    click_on "create event"

    event = Event.last
    expect(current_path).to eq("/events/#{event.id}")

    expect(page).to have_content("Created new event: Curling: USA vs. Canada")
    expect(page).to have_content("Curling: USA vs. Canada")

    expect(page).to have_content("#{date.strftime('%a, %-d %b %Y')} at 7:00 pm")
    expect(page).to have_content("Des Moines, Iowa at Neat Ampitheatre")
  end
end
