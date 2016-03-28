require "rails_helper"

RSpec.feature "UserCanPlaceOrderAndViewPreviousOrder", type: :feature do
  include SpecHelpers
  scenario "user places order and views previous orders" do #, js: true do
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
    ticket = Ticket.last

    visit event_path(event)

    within("#listing-#{listing.id}") do
      select "10", from: "seats"
      select "11", from: "seats"
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
    expect(page).to have_content(listing.tickets.first.format_price)

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

    save_and_open_page

    expect(page).to have_content(order1.id)

  end
end


# Background: an existing user with tickets in the cart
# As a user
# When I visit ‘/cart’
# And click on ‘Checkout’
# Then I should be required to log in
# When I am logged in
# I should see the items in my cart
# When I click on ‘Check Out’
# I click on 'Submit Order'
# I see a form where I enter my name, email, address, and payment info
# When I click on “Total #{total_price}”
# And I should see a message ‘Thank you for your order! :)”
# I click on order history
# And I should see the order just placed in my order history
