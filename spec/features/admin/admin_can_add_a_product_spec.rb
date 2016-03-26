require "rails_helper"

RSpec.feature "AdminCanAddProduct", type: :feature do
  scenario "they see the correct flash message after product is added" do
#     As a logged in admin
# I visit /admin/dashboard
# I click on events > add event
# I am on the path events/new
# I fill in event name, event location, and select date and time from calendar
# I click on Create Event
# I see a message " has been created"
# I visit /events
# and I see this event listed
    admin = create_and_stub_admin
    venue = Venue.create(name: "Pepsi Center", city: "Denver", state: "CO")
    category = Category.create(name: "concerts")
    visit "/admin/dashboard"

    click_on "new event"
    expect(current_path).to eq '/admin/events/new'
    save_and_open_page
    fill_in "name", with: "1989 Tour"
    select "Pepsi Center", from: "venue"
    fill_in "date", with: "2016/08/15"
    fill_in "time", with: "08:00 PM"
    select "concerts", from: "category"
    fill_in "tags", with: "pop"
    attach_file "file", "spec/images/taylor-swift.jpg"
    click_on "create event"

    expect(page).to have_content("Sweet! 1989 Tour on August 15, 2016 at 08:00 PM at Pepsi Center has been created!")

    expect(current_path).to eq "/events/1"
    expect(page).to have_content "1989 Tour"
    expect(page).to have_content "Pepsi Center"
    expect(page).to have_content "08/15/2016"
    expect(page).to have_content "08:00 PM"
    expect(page).to have_css "img"
  end
end
