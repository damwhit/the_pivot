require "rails_helper"

RSpec.feature "AdminCanEditAnEvent", type: :feature do
  include SpecHelpers
  context "change name" do
    scenario "see updated event on index page and flash message" do
      create_and_stub_admin
      event1

      visit "/admin/dashboard"

      fill_in "event[name]", with: "Curling: USA vs. Canada"
      click_on "update event details"

      expect(page).to have_content("Updated event: Curling: USA vs. Canada")
      expect(page).to have_content("Curling: USA vs. Canada")
      expect(page).to_not have_content("Sun Festival")
    end
  end

  context "change venue" do
    scenario "see updated event on index page and flash message" do
      create_and_stub_admin
      event = event1
      venue2

      visit "/admin/dashboard"

      select "Stadium", from: "event[venue_id]"
      click_on "update event details"
      expect(page).to have_content("Updated event: Sun Festival")

      visit "/events/#{event.id}"
      expect(page).to have_content("Stadium")
      expect(page).to_not have_content("Neat Ampitheatre")
    end
  end

  context "change venue" do
    scenario "see updated event on event show page and flash message" do
      create_and_stub_admin
      event = event1
      venue2

      visit "/admin/dashboard"

      select "Stadium", from: "event[venue_id]"
      click_on "update event details"
      expect(page).to have_content("Updated event: Sun Festival")

      visit "/events/#{event.id}"
      expect(page).to have_content("Stadium")
      expect(page).to_not have_content("Neat Ampitheatre")
    end

    scenario "see updated event on event show page and flash message" do
      create_and_stub_admin
      event = event1
      venue2

      visit "/admin/dashboard"

      select "Stadium", from: "event[venue_id]"
      click_on "update event details"
      expect(page).to have_content("Updated event: Sun Festival")

      visit "/events/#{event.id}"
      expect(page).to have_content("Stadium")
      expect(page).to_not have_content("Neat Ampitheatre")
    end
  end

  context "change category" do
    scenario "see updated event on new category page and flash message" do
      create_and_stub_admin
      event1
      category2

      visit "/admin/dashboard"
      select "sports", from: "event[category_id]"
      click_on "update event details"
      expect(page).to have_content("Updated event: Sun Festival")

      visit "/sports"
      expect(page).to have_content("Sun Festival")
      visit "/festivals"
      expect(page).to_not have_content("Neat Ampitheatre")
    end
  end

  context "change status" do
    scenario "see updated event on index page and flash message" do
      create_and_stub_admin
      event1
      category2

      visit "/admin/dashboard"

      select "cancelled", from: "event[status]"
      click_on "update event details"
      expect(page).to have_content("Updated event: Sun Festival")
      within(".events") do
        expect(page).to_not have_css("input[value='Sun Festival']")
      end

      click_on "cancelled events"

      within(".events") do
        expect(page).to have_css("input[value='Sun Festival']")
      end
    end
  end

  context "change date" do
    scenario "see updated event on index page and flash message" do
      create_and_stub_admin
      event = event1
      new_date = Date.today + 25

      visit "/admin/dashboard"

      fill_in "date", with: new_date.strftime("%m/%d/%Y")
      click_on "update event details"
      expect(page).to have_content("Updated event: Sun Festival")

      visit "/events/#{event.id}"
      expect(page).to have_content(new_date.strftime("%a, %-d %b"))
      expect(page).to_not have_content("Thu, 2 Mar")
    end
  end

  context "change time" do
    scenario "see updated event on index page and flash message" do
      create_and_stub_admin
      event = event1
      new_time = "08:00 PM"

      visit "/admin/dashboard"
      fill_in "event[time]", with: new_time
      click_on "update event details"
      expect(page).to have_content("Updated event: Sun Festival")

      visit "/events/#{event.id}"
      expect(page).to have_content("Thu, 2 Mar at 8:00 pm")
    end
  end
end

# select "Neat Ampitheatre", from: "event[venue_id]"
# fill_in "date", with: date.strftime("%m/%d/%Y")
# fill_in "time", with: time
# select "sports", from: "event[category_id]"
# fill_in "tags", with: "family, fringe"
#
# click_on "create event"
#
# event = Event.last
# expect(current_path).to eq("/events/#{event.id}")
#
# expect(page).to have_content("Created new event: Curling: USA vs. Canada")
# expect(page).to have_content("Curling: USA vs. Canada")
#
# expect(page).to have_content("#{date.strftime('%a, %-d %b')} at 7:00 pm")
# expect(page).to have_content("Des Moines, Iowa at Neat Ampitheatre")
