require "rails_helper"

RSpec.feature "AdminCanAddATagToAVenue", type: :feature do
  include SpecHelpers
  scenario "see valid tags on view index page" do
    create_and_stub_admin
    tag1
    tag2
    tag3
    venue = venue1

    visit "/admin/dashboard"
    click_on "venues"

    fill_in "tags", with: "family, death metal, baseball"
    click_on "update tags"

    expect(venue.tags.count).to eq 2
    expect(venue.tags.pluck(:name).sort).to eq ["death metal", "family"]
  end
end
