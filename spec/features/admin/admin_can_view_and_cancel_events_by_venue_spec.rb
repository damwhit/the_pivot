require "rails_helper"

RSpec.feature "AdminCanViewAndCancelEventsbyVenue", type: :feature do
  include SpecHelpers
  scenario "cancelled event no longer on category show page" do
    create_and_stub_admin
    venue = venue1
    event1

    visit "/admin/dashboard"
    click_on "venues"

    expect(current_path).to eq "/admin/venues"

    within(".venues") do
      expect(page).to have_content "Neat Ampitheatre"
      expect(page).to have_content "Des Moines"
      expect(page).to have_content "Iowa"
    end

    click_on "Neat Ampitheatre"

    expect(current_path).to eq "/admin/venues/#{venue.id}"
    expect(page).to have_content "Sun Festival, Des Moines"
    click_on "cancel"
    expect(current_path).to eq admin_events_path

    expect(page).to have_content "Sun Festival has been cancelled"
    visit "/festivals"
    expect(page).to_not have_content "Sun Festival, Des Moines"
  end

  context "guest user" do
    scenario "gets 404 page" do
      venue = venue1

      visit "/admin/venues"
      expect(page).to have_content "The page you were looking for doesn't exist (404)"

      visit "/admin/venues/#{venue.id}"
      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end
  end

  context "logged in user" do
    scenario "gets 404 page" do
      venue = venue1
      user1
      visit "/login"
      fill_in "email", with: "mustachefodays@example.com"
      fill_in "password", with: "password"
      click_on "login"

      visit "/admin/venues"
      expect(page).to have_content "The page you were looking for doesn't exist (404)"

      visit "/admin/venues/#{venue.id}"
      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end
  end
end
