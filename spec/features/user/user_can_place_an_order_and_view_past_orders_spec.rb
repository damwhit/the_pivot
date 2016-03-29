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

    click_on "submit"

    stripe_iframe = all("iframe[name=stripe_checkout_app]").last
    Capybara.within_frame stripe_iframe do
      page.execute_script(%Q{ $("input#email").val("fodays@example.com"); })
      sleep 1
      page.execute_script(%Q{ $("input#shipping-name").val("Sam"); })
      sleep 1
      page.execute_script(%Q{ $("input#shipping-street").val("1510 Blake St"); })
      sleep 1
      page.execute_script(%Q{ $("input#shipping-zip").val("80000"); })
      sleep 1
      page.execute_script(%Q{ $("input#shipping-city").val("Denver"); })

      sleep 3

      click_on "Payment Info"

      page.execute_script(%Q{ $("input#card_number").val("4242 4242 4242 4242"); })
      sleep 1
      page.execute_script(%Q{ $("input#cc-exp").val("11 2020"); })
      sleep 1
      page.execute_script(%Q{ $("input#cc-csc").val("222"); })
      sleep 1

      click_on "Total $8.00"
    end

    sleep 10

    expect(Ticket.find(ticket.id).status).to eq("purchased")

    click_on "order history"

    order = Order.last

    expect(page).to have_content(order.id)

    within("#upcoming-order-#{order.id}") do
      click_on "details"
    end

    expect(page).to have_content(event.name)
    expect(page).to have_content(event.format_date)
    expect(page).to have_content(ticket.format_price)
  end
end
