require "rails_helper"

RSpec.feature "UserViewsDashboard", type: :feature do
  pending
  include SpecHelpers
  scenario "user views upcoming events, listings, and contact information" do
    pending
    make_listings_and_tickets_dashboard

    user = User.last

    user_listing = Listing.find_by(user_id: user.id)

    event1 = Event.first

    event2 = Event.last

    order = user.orders.create(street: "1600 pennslyvania",
                               city: "washington",
                               state: "District of Columbia",
                               zip: "46250",
                               fullname: "jonathon adams",
                               first_name: "jonathon",
                               last_name: "adams",
                               email: "spam@foundingfathers.biz")

    order.tickets << Ticket.find_by(seat: "10")
    order.tickets << Ticket.find_by(seat: "11")
    order.tickets << Ticket.find_by(seat: "30")
    order.tickets << Ticket.find_by(seat: "31")
    order.tickets << Ticket.find_by(seat: "1")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within(".user-nav") do
      click_on "dashboard"
    end

    within(".user-events") do
      expect(page).to have_content(event1.name)
      expect(page).to have_content(event1.format_date)
      expect(page).to have_content(event1.venue.name)
      expect(page).to_not have_content(event2.name)
    end

    within(".table-listings") do
      expect(page).to have_content(user_listing.id)
      expect(page).to have_content(user_listing.format_date)
    end

    within(".user-info") do
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.email)
    end

    click_on "view all orders"

    within("#orders") do
      expect(page).to have_content(order.id)
      expect(page).to have_content(order.date)
    end
  end

  scenario "user can only view 3 active events in dashboard" do
    buyer = user1

    seller = user2

    event = event1

    event2 = category1.events.find_or_create_by!(
      name: "Moon Festival",
      venue_id: venue1.id,
      time: "March 02, 2020 16:00",
      status: "active")

    event3 = category1.events.find_or_create_by!(
      name: "Happy Time",
      venue_id: venue1.id,
      time: "March 20, 2022 16:00",
      status: "active")

    event4 = category1.events.find_or_create_by!(
      name: "Fun Extravaganza",
      venue_id: venue1.id,
      time: "July 10, 2017 16:00",
      status: "active")

    listing1 = event.listings.new(user_id: seller.id)
    listing1.tickets << Ticket.new(price: 800, seat: "22", row: "7")
    listing1.save

    listing2 = event2.listings.new(user_id: seller.id)
    listing2.tickets << Ticket.new(price: 800, seat: "80", row: "34")
    listing2.save

    listing3 = event3.listings.new(user_id: seller.id)
    listing3.tickets << Ticket.new(price: 800, seat: "89", row: "36")
    listing3.save

    listing4 = event4.listings.new(user_id: seller.id)
    listing4.tickets << Ticket.new(price: 800, seat: "43", row: "74")
    listing4.save

    order = buyer.orders.create(street: "1600 pennslyvania",
                                city: "washington",
                                state: "District of Columbia",
                                zip: "46250",
                                fullname: "jonathon adams",
                                first_name: "jonathon",
                                last_name: "adams",
                                email: "spam@foundingfathers.biz")

    order.tickets << Ticket.find_by(seat: "22")
    order.tickets << Ticket.find_by(seat: "80")
    order.tickets << Ticket.find_by(seat: "89")
    order.tickets << Ticket.find_by(seat: "43")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(buyer)

    visit root_path

    within(".user-nav") do
      click_on "dashboard"
    end

    expect(page).to have_selector(".user-events", count: 3)
  end
end
