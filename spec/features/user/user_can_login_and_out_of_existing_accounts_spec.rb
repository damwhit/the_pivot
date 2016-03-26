require "rails_helper"

RSpec.feature "UserCanLogInandOutofExistingAccount", type: :feature do
  scenario "user logs in and out of account" do
    user = User.create(first_name: "John",
                       last_name: "Adams",
                       fullname: "John Adams",
                       email: "email@example.com",
                       password: "password")

    visit "/"

    click_on "sign in"

    fill_in "email", with: user.email
    fill_in "password", with: user.password

    click_on "login"

    within("div .alert") do
      expect(page).to have_content("Hi John, welcome to ticketcacher!")
    end

    expect(current_path).to eq("/users/#{user.id}/dashboard")

    expect(page).to_not have_link("login")
    expect(page).to have_content("John")
    expect(page).to have_link("logout")
    expect(page).to have_link("order history")

    click_on "logout"

    expect(page).to have_link("sign in")
    expect(page).to_not have_link("logout")
    expect(page).to_not have_link("order history")
    expect(page).to_not have_content("John Adams")
  end
end
