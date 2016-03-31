require "rails_helper"

RSpec.feature "AdminCanAddATagToAnEvent", type: :feature do
  include SpecHelpers
  scenario "see tag on event show page" do
    create_and_stub_admin
    tag_1 = tag1
    tag_2 = tag2
    tag3
    event1

    visit "/admin/dashboard"

    fill_in "tags", with: "family, death metal"
    click_on "update event details"

    click_on "#{event1.id}"

    expect(page).to have_content "family"
    expect(page).to have_content "death metal"
    expect(page).to_not have_content "basketball"
  end

  scenario "do not see uncreated tags on event page" do
    create_and_stub_admin
    tag_1 = tag1
    event1

    visit "/admin/dashboard"

    fill_in "tags", with: "family, late-night"
    click_on "update event details"

    click_on "#{event1.id}"

    expect(page).to have_content "family"
    expect(page).to_not have_content "late-night"
  end
end
