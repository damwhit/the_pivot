require "rails_helper"

RSpec.feature "AdminCanCreateTags", type: :feature do
  include SpecHelpers
  scenario "see tags index page" do
    create_and_stub_admin

    visit "/admin/dashboard"

    click_on "tags"
    click_on "new tag"
    expect(current_path).to eq("/admin/tags/new")

    fill_in "tag[name]", with: "taylor swift"
    click_on "create tag"

    expect(page).to have_content "created new tag: taylor swift!!!"
    within(".tags") do
      expect(page).to have_content "taylor swift"
    end
  end

  context "invalid tag name" do
    scenario "sees create form again" do
      tag1
      create_and_stub_admin

      visit "/admin/tags/new"
      fill_in "tag[name]", with: "family"
      click_on "create tag"

      expect(page).to have_content "couldn't create tag... try again!!!"
    end

    scenario "sees create form again" do
      create_and_stub_admin

      visit "/admin/tags/new"
      fill_in "tag[name]", with: ""
      click_on "create tag"

      expect(page).to have_content "couldn't create tag... try again!!!"
    end
  end

  context "non-authorized users" do
    scenario "sees 404 page" do
      tag1

      visit "/admin/tags/new"
      expect(page).to_not have_css ".tags"
      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end

    scenario "sees 404 page" do
      user1
      visit "/login"
      fill_in "email", with: "mustachefodays@example.com"
      fill_in "password", with: "password"
      click_on "login"

      visit "/admin/tags/new"

      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end
  end
end
