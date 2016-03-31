require "rails_helper"

RSpec.feature "UserViewsPastAndUpcomingTickets", type: :feature do
  include SpecHelpers
  scenario "user views order history and sees upcoming and passed tickets" do
    seller1 = user1
    seller2 = user2

    event1 = category1.events.create!(
      name: "Sun Festival",
      venue_id: venue1.id,
      time: "March 02, 2017 16:00",
      status: "active")

    event2 = category1.events.create!(
      name: "EDM Spectacular",
      venue_id: venue1.id,
      time: "November 20, 2020 18:00",
      status: "active")

    event3 = category1.events.create!(
      name: "Donuts Make Noise",
      venue_id: venue1.id,
      time: "July 20, 2010 18:00",
      status: "active")

    event4 = category1.events.create!(
      name: "Hello",
      venue_id: venue1.id,
      time: "June 02, 2018 18:00",
      status: "cancelled")

    ticket1 = Ticket.new(price: 800, seat: "80", row: "20")
    ticket2 = Ticket.new(price: 800, seat: "81", row: "20")
    ticket3 = Ticket.new(price: 1000, seat: "56", row: "23")
    ticket4 = Ticket.new(price: 4000, seat: "5", row: "4")
    ticket5 = Ticket.new(price: 9000, seat: "9", row: "2")

    listing_1 = event1.listings.new(user_id: seller1.id)
    listing_1.tickets << ticket1
    listing_1.tickets << ticket2
    listing_1.save

    listing_2 = event2.listings.new(user_id: seller2.id)
    listing_2.tickets <<  ticket3
    listing_2.save

    listing_3 = event3.listings.new(user_id: seller2.id)
    listing_3.tickets <<  ticket4
    listing_3.save

    listing_4 = event4.listings.new(user_id: seller2.id)
    listing_4.tickets <<  ticket5
    listing_4.save

    user = User.create(first_name: "John",
                       last_name: "Adams",
                       fullname: "John Adams",
                       email: "email@example.com",
                       password: "password")

    order1 = user.orders.create(street: "1600 pennslyvania",
                                city: "washington",
                                state: "District of Columbia",
                                zip: "46250",
                                fullname: "jonathon adams",
                                first_name: "jonathon",
                                last_name: "adams",
                                email: "spam@foundingfathers.biz")

    order2 = user.orders.create(street: "1600 pennslyvania",
                                city: "washington",
                                state: "District of Columbia",
                                zip: "46250",
                                fullname: "jonathon adams",
                                first_name: "jonathon",
                                last_name: "adams",
                                email: "spam@foundingfathers.biz")

    order1.tickets << ticket1
    order1.tickets << ticket2
    order1.tickets << ticket4
    order1.tickets << ticket5

    order2.tickets << ticket3

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    click_on "order history"

    within("#orders") do
      expect(page).to have_content(order1.id)
      expect(page).to have_content(order1.date)
      expect(page).to have_content(order2.id)
      expect(page).to have_content(order2.date)
    end

    within("#order-#{order1.id}") do
      click_on "details"
    end

    within(".upcoming-events") do
      expect(page).to have_content(ticket1.seat)
      expect(page).to have_content(ticket2.seat)
      expect(page).to have_content(event1.name)
      expect(page).to_not have_content(ticket4.seat)
    end

    within(".past-events") do
      expect(page).to have_content(ticket4.seat)
      expect(page).to have_content(event3.name)
      expect(page).to_not have_content(ticket5.seat)
    end

    within(".cancelled-events") do
      expect(page).to have_content(ticket5.seat)
      expect(page).to have_content(event4.name)
      expect(page).to_not have_content(ticket1.seat)
    end
  end
end
