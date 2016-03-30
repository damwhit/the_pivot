require "rails_helper"

RSpec.feature "AdminCanViewAndCancelEventsbyCategory", type: :feature do
  include SpecHelpers
  scenario "cancelled event no longer on category show page" do
    create_and_stub_admin
    category1
    category2
    event1

    visit "/admin/dashboard"
    click_on "categories"

    expect(current_path).to eq "/admin/categories"

    within(".categories") do
      expect(page).to have_content "festivals"
    end

    within(".categories") do
      click_on "festivals"
    end

    expect(current_path).to eq "/festivals"
    expect(page).to have_content "Sun Festival, Des Moines"
    click_on "cancel"
    expect(current_path).to eq admin_events_path

    expect(page).to have_content "Sun Festival has been cancelled"
    visit "/festivals"
  end

  context "guest user" do
    scenario "gets 404 page" do
      visit "admin/categories"

      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end

    scenario "does not see cancel link" do
      category1
      event1

      visit "/festivals"

      expect(page).to_not have_button "cancel"
    end
  end

  context "logged in user" do
    scenario "gets 404 page" do
      user1
      visit "/login"
      fill_in "email", with: "mustachefodays@example.com"
      fill_in "password", with: "password"
      click_on "login"

      visit "admin/categories"

      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end

    scenario "does not see cancel link" do
      user1
      visit "/login"
      fill_in "email", with: "mustachefodays@example.com"
      fill_in "password", with: "password"
      click_on "login"
      category1
      event1

      visit "/festivals"

      expect(page).to_not have_button "cancel"
    end
  end
end
