require "rails_helper"

RSpec.feature "AdminCanEditAnEvent", type: :feature do
  include SpecHelpers

  context "click on cancel event button" do
    scenario "see cancelled status on event page, no listings, and flash message" do
      create_and_stub_admin
      make_listing
      listing = Listing.last
      event = listing.event

      visit "/admin/dashboard"
      click_on event.id.to_s
      click_on "cancel event"
      expect(page).to have_content "Sun Festival has been cancelled"

      visit "/events/#{event.id}"
      expect(page).to have_content "CANCELLED"
      expect(page).to_not have_content "Available Listings"

      listing = Listing.find(listing.id)
      expect(listing.status).to eq "inactive"
      listing.tickets.each do |ticket|
        expect(ticket.status).to_not eq "active"
      end
    end
  end

  context "update on admin dashboard" do
    scenario "see cancelled status on event page, no listings, and flash message" do
      create_and_stub_admin
      make_listing
      listing = Listing.last
      event = listing.event

      visit "/admin/dashboard"
      select "cancelled", from: "event[status]"
      click_on "update event details"
      expect(page).to have_content "Sun Festival has been cancelled"
      listing = Listing.last

      visit "/events/#{event.id}"
      expect(page).to have_content "CANCELLED"
      expect(page).to_not have_content "Available Listings"
      expect(listing.status).to eq "inactive"
      listing.tickets.each do |ticket|
        expect(ticket.status).to_not eq "active"
      end
    end
  end
end
