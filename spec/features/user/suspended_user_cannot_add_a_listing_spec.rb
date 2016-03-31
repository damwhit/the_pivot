require "rails_helper"

RSpec.feature "SuspendedUserCannotAddListings", type: :feature do
  include SpecHelpers
  def setup
    @user = User.create(first_name: "John",
                        last_name: "Adams",
                        fullname: "John Adams",
                        email: "email@example.com",
                        password: "password",
                        status: "suspended")
    @event1 = event1
    @event2 = event2
  end
  scenario "user with suspended status cannot add a listing" do
    setup
    visit "/"

    click_on "sign in"
    fill_in "email", with: @user.email
    fill_in "password", with: @user.password

    click_on "login"

    click_on "sell tickets"
    click_on "create listing"

    expect(current_path).to eq("/")

    within".alert" do
      expect(page).to have_content("sorry, you cannot add a listing :(")
    end
  end
end
