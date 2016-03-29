require "rails_helper"

RSpec.feature "UserCanPlaceOrderAndViewPreviousOrder", type: :feature do
  include SpecHelpers
  scenario "user places order and views previous orders", js: true do
    make_listings_and_tickets

    user = User.create(
      first_name: "Sam",
      last_name: "White",
      email: "fodays@example.com",
      password: "password",
      role: 0,
      fullname: "Sam White"
    )

    event = Event.last
    listing = Listing.first
    ticket = Ticket.first

    visit event_path(event)

    within("#listing-#{listing.id}") do
      select "10", from: "seats"
      click_on "add to cart!"
    end

    visit "/cart"

    click_on "Checkout"

    fill_in "name", with: user.name
    fill_in "email", with: user.email
    fill_in "password", with: user.password

    click_on "continue"

    expect(current_path).to eq("/checkout")

    expect(page).to have_content(event.name)
    expect(page).to have_content(ticket.format_price)

    # click_on "submit"
    #
    # within(".stripe-checkout") do
    #   fill_in "Email", with: user.email
    #   fill_in "Name", with: user.name
    #   fill_in "Address", with: "1510 Blake St"
    #   fill_in "ZIP", with: "80000"
    #   fill_in "City", with: "denver"
    #   click_on "Payment Info"
    # end
    #
    # save_and_open_page

    order1 = user.orders.create(street: "1600 pennslyvania",
                                city: "washington",
                                state: "District of Columbia",
                                zip: "46250",
                                fullname: "jonathon adams",
                                first_name: "jonathon",
                                last_name: "adams",
                                email: "spam@foundingfathers.biz")

    order1.order_tickets.create(ticket_id: ticket.id)

    click_on "order history"

    expect(page).to have_content(order1.id)

    within("#upcoming-order-#{order1.id}") do
      click_on "details"
    end

    expect(page).to have_content(event.name)
    expect(page).to have_content(event.format_date)
    expect(page).to have_content(ticket.format_price)
  end
end
