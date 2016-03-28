require "rails_helper"

RSpec.feature "AdminViewsUpcomingEvents", type: :feature do
  include SpecHelpers

  scenario "see upcoming events by default" do
    create_and_stub_admin
    upcoming = event1
    past = event2
    visit "/admin/dashboard"

    within(".events") do
      expect(page).to have_content upcoming.id
      expect(page).to have_content upcoming.name
      expect(page).to_not have_content past.id
      expect(page).to have_content past.name
    end
  end
end
