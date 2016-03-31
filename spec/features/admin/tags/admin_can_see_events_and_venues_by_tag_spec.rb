require "rails_helper"

RSpec.feature "AdminCanViewEventsAndVenuesByTag", type: :feature do
  include SpecHelpers
  scenario "sees event and venue on tag show page" do
    create_and_stub_admin
    tag = tag1
    event = event1
    event_2 = event2
    event.tags << tag
    event.save
    venue_1 = venue1
    venue_2 = venue2
    venue_1.tags << tag
    venue_1.save

    visit "/admin/dashboard"

    click_on "tags"
    click_on "#{tag.id}"

    within(".events") do
      expect(page).to have_content "Sun Festival"
      expect(page).to have_content "Neat Ampitheatre"
      expect(page).to have_content "Thu, 2 Mar 2017"
      expect(page).to have_content "4:00 pm"
      expect(page).to_not have_content "Moon Festival"
    end

    within(".venues") do
      expect(page).to have_content "Neat Ampitheatre"
      expect(page).to_not have_content "Stadium"
    end
  end

  context "non-authorized users" do
    scenario "sees 404 page" do
      tag = tag1

      visit "/admin/tags/#{tag.id}"

      expect(page).to_not have_css ".events"
      expect(page).to_not have_css ".venues"
      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end

    scenario "sees 404 page" do
      user1
      visit "/login"
      fill_in "email", with: "mustachefodays@example.com"
      fill_in "password", with: "password"
      click_on "login"

      tag = tag1

      visit "/admin/tags/#{tag.id}"

      expect(page).to_not have_css ".events"
      expect(page).to_not have_css ".venues"
      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end
  end
end
