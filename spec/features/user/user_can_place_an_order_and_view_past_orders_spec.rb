require "rails_helper"

RSpec.feature "UserCanPlaceOrderAndViewPreviousOrder", type: :feature do
  include SpecHelpers
  scenario "user places order and views previous orders", js: true do
    make_listings_and_tickets

    user = user1

    event = Event.last
    listing = Listing.first

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

    #expect(current_path).to eq("/checkout")

    expect(page).to have_content(event.name)
    expect(page).to have_content(listing.tickets.first.format_price)

    click_on "Total: $10"

    expect(page).to have_content("thank you for your order! :)")

    click_on "order history"
    expect(page).to have_content(event.name)

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
