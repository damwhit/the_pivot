require "rails_helper"

RSpec.feature "UserCanLogInandOutofExistingAccount", type: :feature do
  pending
  def setup
    @user = User.create(first_name: "John",
                        last_name: "Adams",
                        fullname: "John Adams",
                        email: "email@example.com",
                        password: "password")
  end

  scenario "user logs in and out of account" do
    pending
    setup

    visit "/"

    click_on "sign in"

    fill_in "email", with: @user.email
    fill_in "password", with: @user.password

    click_on "login"

    within("div .alert") do
      expect(page).to have_content("Hi John, welcome to ticketcacher!")
    end

    expect(current_path).to eq("/dashboard")

    expect(page).to_not have_link("login")
    within(".sidebar-nav") do
      expect(page).to have_content("john")
    end

    expect(page).to have_link("logout")
    expect(page).to have_link("order history")

    click_on "logout"
    expected = "Sad to see you go John. Come back again soon. 👋"
    within(".alert") do
      expect(page).to have_content(expected)
    end

    expect(page).to have_link("sign in")
    expect(page).to_not have_link("logout")
    expect(page).to_not have_link("order history")
    expect(page).to_not have_content("John Adams")
  end

  scenario "user cannot login with incorrect password" do
    setup

    visit "/"

    click_on "sign in"

    fill_in "email", with: @user.email
    fill_in "password", with: "notpassword"

    click_on "login"

    within(".alert") do
      expected = "Sorry, friend. Something went wrong :(... Please try again."
      expect(page).to have_content(expected)
    end
  end
end
