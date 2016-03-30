require "rails_helper"

RSpec.feature "UserViewsDashboard", type: :feature do
  include SpecHelpers
  scenario "user views upcoming events, listings, and contact information" do
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
end
