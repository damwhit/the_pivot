require "rails_helper"

RSpec.feature "UserAddsListingForAnEvent", type: :feature do
  include SpecHelpers
  def setup
    @user = User.create(first_name: "John",
                        last_name: "Adams",
                        fullname: "John Adams",
                        email: "email@example.com",
                        password: "password")
    @event = event
  end

  scenario "user adds a listing", js: true do
    setup

    visit "/"

    expect(page).to_not have_content("sell tickets")

    click_on "sign in"
    fill_in "email", with: @user.email
    fill_in "password", with: @user.password

    click_on "login"

    within("#sell") do
      expect(page).to have_content("sell tickets")
    end

    click_on "sell tickets"

    expect(current_path).to eq("/sell")

    expect(page).to have_button("create listing")
    expect(page).to have_content("#{@event.name}")

    click_on "create listing"

    expect(current_path).to eq("/users/#{@user.id}/listings/new")

    fill_in "price", with: "10"
    fill_in "row_number", with: "5"
    fill_in "seat_number_1", with: "10"

    click_on "add seat"

    fill_in "seat_number_2", with: "11"

    click_on "add seat"

    fill_in "seat_number_3", with: "12"

    click_on "create listing"

    expect(current_path).to eq("/dashboard")

  end
end

# As a logged in user
# When I visit ‘/’
# And click on ‘sell tickets’
# my current page should be '/sell'
# I see all events paginated and ordered by closest to current date.
# When I click on "sell tickets for this event" next to the event that I want to sell tickets for.
# And I fill in the ticket info Row, seat number and the price I would like to sell it for
# And I click on '+'
# I get an extra row with only the seat number field
# I fill in the ticket info seat number
# And I click on 'Submit listing'
# I should see 'Your tickets are up for sale!'
# And I should see the new listing posted on my dashboard