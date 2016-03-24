require "rails_helper"

RSpec.feature "UserViewsEventsByCategory", type: :feature do
  scenario "user views events by category" do
    pending

    event1 = make_events[:event1]
    event2 = make_events[:event2]
    event3 = make_events[:event3]
    #experimenting with spec helper

    # category1 = Category.create(name:"Festivals")
    # category2 = Category.create(name:"Sports")
    #
    # venue1 = Venue.create(name: "Outside", city: "Lima")
    # venue2 = Venue.create(name: "Stadium", city: "Denver")
    #
    # event1 = category1.events.create(name: "Sun Festival", image_file_path: 'http://mortenbentzon.com/wp-content/uploads/2014/07/midnightsun_blog161-e1406761557421.jpg', venue_id: venue.id, time: "8:00", status: "active")
    # event2 = category.events.create(name: "EDM Spectacular", image_file_path: 'http://mortenbentzon.com/wp-content/uploads/2014/07/midnightsun_blog161-e1406761557421.jpg', venue_id: venue.id, time: "7:00", status: "active")
    # event3 = category2.events.create(name: "Basketball", image_file_path: 'http://a57.foxnews.com/global.fncstatic.com/static/managed/img/fn-latino/sports/660/371/us%20beats%20brazil.jpg?ve=1&tl=1', venue_id: venue2.id, time: "8:00", status: "active")

    visit root_path

    click_on "festivals"

    expect(page).to have_content(event1.name)
    expect(page).to have_content(event1.venue)
    expect(page).to have_content(event2.name)
    expect(page).to have_content(event2.venue)
    expect(page).to_not have_content(event3.name)
  end
end



# As a visitor
# When I visit the root page
# I see a listing of events by category
# When I click on a category
# I see all the events associated with that category
