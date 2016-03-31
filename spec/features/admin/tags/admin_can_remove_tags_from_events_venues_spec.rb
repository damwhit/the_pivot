require "rails_helper"

RSpec.feature "AdminCanRemoveTagAssociations", type: :feature do
  include SpecHelpers
  scenario "does not see tag on event page" do
    create_and_stub_admin
    tag = tag1
    event = event1

    visit "/admin/dashboard"
    fill_in "tags", with: "family"
    click_on "update event details"

    click_on "tags"
    click_on tag.id.to_s
    click_on "remove family tag"

    expect(page).to have_content "Removed family from Sun Festival"

    within(".events") do
      expect(page).to_not have_content "Sun Festival"
    end

    visit "/events/#{event.id}"
    expect(page).to_not have_content "family"
  end

  scenario "does not see tag on venue page" do
    create_and_stub_admin
    tag = tag1
    venue1

    visit "/admin/dashboard"
    click_on "venues"
    fill_in "tags", with: "family"
    click_on "update tags"

    click_on "tags"
    click_on tag.id.to_s
    click_on "remove family tag"

    expect(page).to have_content "Removed family from Neat Ampitheatre"

    within(".venues") do
      expect(page).to_not have_content "Neat Ampitheatre"
    end
  end
end
