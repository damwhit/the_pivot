require "rails_helper"

RSpec.feature "AdminCanRemoveTagAssociations", type: :feature do
  include SpecHelpers
  scenario "does not see tag on event or venue page" do
    create_and_stub_admin
    tag = tag1
    event = event1
    venue = venue1
    event.tags << tag
    event.save
    venue.tags << tag

    visit "/admin/dashboard"

    click_on "tags"
    click_on "delete tag"

    expect(page).to have_content "Removed family tag"
    expect(current_path).to eq "/admin/tags"

    within(".tags") do
      expect(page).to_not have_content tag.id
      expect(page).to_not have_content "family"
    end

    visit "/events/#{event.id}"
    expect(page).to_not have_content "family"
    visit "/admin/venues"
    expect(page).to_not have_css "input[value='family']"
  end
end
