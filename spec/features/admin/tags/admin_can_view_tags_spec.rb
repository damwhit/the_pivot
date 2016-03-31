require "rails_helper"

RSpec.feature "AdminCanViewTags", type: :feature do
  include SpecHelpers
  scenario "see tags index page" do
    create_and_stub_admin
    tag1
    tag2
    tag3

    visit "/admin/dashboard"

    click_on "tags"
    expect(current_path).to eq("/admin/tags")

    within(".tags") do
      expect(page).to have_content "family"
      expect(page).to have_content "basketball"
      expect(page).to have_content "death metal"
    end
  end

  context "non-authorized users" do
    scenario "sees 404 page" do
      tag1

      visit "/admin/tags"
      expect(page).to_not have_css ".tags"
      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end

    scenario "sees 404 page" do
      user1
      visit "/login"
      fill_in "email", with: "mustachefodays@example.com"
      fill_in "password", with: "password"
      click_on "login"

      visit "/admin/tags"

      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end
  end
end
