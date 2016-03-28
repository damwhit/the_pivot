require "rails_helper"

RSpec.feature "AdminCanCreateANewCategory", type: :feature do
  include SpecHelpers
  scenario "see new category on index page" do
    create_and_stub_admin

    visit "/admin/dashboard"
    click_on "categories"
    click_on "new category"

    fill_in "name", with: "Musicals"
    click_on "create category"

    expect(current_path).to eq "/admin/categories"

    expect(page).to have_content "Created category: Musicals"
    within(".categories") do
      expect(page).to have_field "category[name]", with: "Musicals"
    end
  end

  context "duplicate category name" do
    scenario "sees creation form and error message" do
      create_and_stub_admin
      category1

      visit "/admin/dashboard"
      click_on "categories"
      click_on "new category"

      fill_in "name", with: "festivals"
      click_on "create category"

      expect(page).to have_content "Sorry, could not create that new category."
    end
  end

  context "empty category name" do
    scenario "sees creation form and error message" do
      create_and_stub_admin
      category1

      visit "/admin/dashboard"
      click_on "categories"
      click_on "new category"

      fill_in "name", with: ""
      click_on "create category"

      expect(page).to have_content "Sorry, could not create that new category."
    end
  end

  context "guest user" do
    scenario "gets 404 page" do
      visit "admin/categories/new"

      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end
  end

  context "logged in user" do
    scenario "gets 404 page" do
      user1
      visit "/login"
      fill_in "email", with: "mustachefodays@example.com"
      fill_in "password", with: "password"
      click_on "login"

      visit "admin/categories/new"

      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end
  end
end
