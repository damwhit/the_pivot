require "rails_helper"

RSpec.feature "AdminCanLoginAndViewDashboard", type: :feature do
  scenario "Admin sees dashboard when they successfully login" do
    admin = User.create(first_name: "John",
                        last_name: "Adams",
                        fullname: "John Adams",
                        email: "admin@example.com",
                        password: "password",
                        role: 1)

    visit root_path

    click_on "sign in"

    fill_in "email", with: admin.email
    fill_in "password", with: admin.password
    click_on "login"

    expect(current_path).to eq(admin_dashboard_path)

    expect(page).to have_content("Hi John, welcome to ticketcacher!")
  end
end
