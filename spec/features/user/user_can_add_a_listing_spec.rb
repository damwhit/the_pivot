require "rails_helper"

RSpec.feature "UserAddsListingForAnEvent", type: :feature do
  include SpecHelpers
  def setup
    @user = User.create(first_name: "John",
                        last_name: "Adams",
                        fullname: "John Adams",
                        email: "email@example.com",
                        password: "password")
    @event1 = event1
    @event2 = event2
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
    expect(page).to have_content("Sun Festival")
    expect(page).to_not have_content(event2.name.to_s)

    expect(page).to have_button("create listing")
    expect(page).to have_content(@event1.name.to_s)

    click_on "create listing"

    expect(current_path).to eq("/events/#{@event1.id}/listings/new")

    fill_in "price", with: "10"
    fill_in "row", with: "5"
    fill_in "seat_number_1", with: "10"

    click_on "add seat"

    fill_in "seat_number_2", with: "11"

    click_on "add seat"

    fill_in "seat_number_3", with: "12"

    click_on "create listing"

    expect(current_path).to eq("/dashboard")

    within(".table-listings") do
      expect(page).to have_content("$30.00")

      expect(page).to have_content(Time.now.utc.strftime "%Y-%m-%d")

      expect(page).to have_content("active")
    end
    within".alert" do
      expect(page).to have_content("Your tickets are up for sale!")
    end
  end
end
