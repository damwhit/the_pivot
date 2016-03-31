require "rails_helper"

RSpec.feature "AdminViewsEventsByStatus", type: :feature do
  include SpecHelpers

  scenario "see upcoming events by default" do
    create_and_stub_admin
    events = make_events
    upcoming = events[:event1]
    past = event3
    visit "/admin/dashboard"

    within(".events") do
      expect(page).to have_content upcoming.id
      expect(page).to have_css "input[value='#{upcoming.name}']"

      expect(page).to_not have_content past.id
      expect(page).to_not have_content past.name
    end
  end

  scenario "see upcoming events" do
    create_and_stub_admin
    events = make_events
    upcoming = events[:event1]
    past = event3
    visit "/admin/dashboard"
    click_on "upcoming events"

    within(".events") do
      expect(page).to have_content upcoming.id
      expect(page).to have_css "input[value='#{upcoming.name}']"

      expect(page).to_not have_content past.id
      expect(page).to_not have_css "input[value='#{past.name}']"
    end
  end

  scenario "see past events" do
    create_and_stub_admin
    events = make_events
    upcoming = events[:event1]
    past = event3
    visit "/admin/dashboard"
    click_on "past events"

    within(".events") do
      expect(page).to_not have_content upcoming.id
      expect(page).to_not have_css "input[value='#{upcoming.name}']"

      expect(page).to have_content past.id
      expect(page).to have_content past.name
    end
  end

  scenario "see all events" do
    create_and_stub_admin
    events = make_events
    past = event3
    visit "/admin/dashboard"
    click_on "all events"

    within(".events") do
      events.each do |_key, event|
        expect(page).to have_content event.id
        expect(page).to have_css "input[value='#{event.name}']"
      end
      expect(page).to have_content past.id
      expect(page).to have_content past.name
    end
  end

  scenario "see cancelled events" do
    create_and_stub_admin
    events = make_events
    upcoming = events[:event1]
    upcoming.update(status: "cancelled")
    past = event3
    visit "/admin/dashboard"
    click_on "cancelled events"

    within(".events") do
      expect(page).to have_content upcoming.id
      expect(page).to have_content upcoming.name
      expect(page).to_not have_content past.name
      expect(page).to_not have_content events[:event2].id
      expect(page).to_not have_content events[:event2].name
    end
  end

  scenario "do not see cancelled events in the future" do
    create_and_stub_admin
    events = make_events
    cancelled = events[:event1]
    cancelled.update(status: "cancelled")
    visit "/admin/dashboard"
    click_on "upcoming events"

    within(".events") do
      expect(page).to have_content events[:event2].id
      expect(page).to have_css "input[value='#{events[:event2].name}']"
      expect(page).to_not have_content cancelled.id
      expect(page).to_not have_css "input[value='#{cancelled.name}']"
    end
  end
end
