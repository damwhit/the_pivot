require "rails_helper"

RSpec.feature "AdminCanCreateANewCategory", type: :feature do
  include SpecHelpers
  scenario "see updated category name on index page" do
    create_and_stub_admin
    category1

    visit "/admin/dashboard"
    click_on "categories"

    fill_in "category[name]", with: "Musicals"
    click_on "update category"

    expect(current_path).to eq "/admin/categories"

    expect(page).to have_content "Updated category: Musicals"
    within(".categories") do
      expect(page).to have_field "category[name]", with: "Musicals"
      expect(page).not_to have_field "category[name]", with: "festivals"
    end
  end

  context "duplicate name" do
    scenario "sees unable to update category message" do
      create_and_stub_admin
      category1
      category2

      visit "/admin/dashboard"
      click_on "categories"

      within ("#category-#{category1.id}") do
        fill_in "category[name]", with: "sports"
        click_on "update category"
      end

      expect(page).to have_content "sorry, unable to update category"
      within(".categories") do
        expect(page).to have_field "category[name]", with: "festivals"
        expect(page).to have_field "category[name]", with: "sports"
      end
    end
  end

  context "blank name" do
    scenario "sees unable to update category message" do
      create_and_stub_admin
      category1
      category2

      visit "/admin/dashboard"
      click_on "categories"

      within ("#category-#{category1.id}") do
        fill_in "category[name]", with: ""
        click_on "update category"
      end

      expect(page).to have_content "sorry, unable to update category"
      within(".categories") do
        expect(page).to have_field "category[name]", with: "festivals"
        expect(page).to have_field "category[name]", with: "sports"
      end
    end
  end

  context "guest user" do
    scenario "gets 404 page" do
      visit "admin/categories"

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

      visit "admin/categories"

      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end
  end
end
