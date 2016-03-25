require "rails_helper"

RSpec.feature "AdminCanLoginAndViewDashboard", type: :feature do
  before(:each) do
    @admin = User.create(first_name: "John",
                         last_name: "Adams",
                         fullname: "John Adams",
                         email: "admin@example.com",
                         password: "password",
                         role: 1)
    visit root_path
    click_on "sign in"
  end

  scenario "sees dashboard when they successfully login" do
    fill_in "email", with: @admin.email
    fill_in "password", with: @admin.password
    click_on "login"

    expect(current_path).to eq(admin_dashboard_path)

    expect(page).to have_content("Hi John, welcome to ticketcacher!")
  end

  context "wrong login credentials" do
    scenario "sees error if email not correct" do
      fill_in "email", with: "wrongemail@example.com"
      fill_in "password", with: @admin.password
      click_on "login"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Sorry, friend.  Something went wrong :(... Please try again.")
    end

    scenario "sees error if password not correct" do
      fill_in "email", with: @admin.email
      fill_in "password", with: "incorrectpassword"
      click_on "login"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Sorry, friend.  Something went wrong :(... Please try again.")
    end
  end
end
