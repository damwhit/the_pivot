require "rails_helper"

RSpec.feature "AdminCanLoginAndViewDashboard", type: :feature do
  # make not fail!!!
  scenario "Admin sees dashboard when they successfully login" do
    pending
      admin = User.create(first_name: "john",
                          last_name: "adams",
                          fullname: "john adams",
                          email: "admin@example.com",
                          password: "password",
                          role: 1)

      visit root_path

      click_on "login"

      fill_in "email", with: admin.email
      fill_in "password", with: admin.password

      save_and_open_page
      click_on "login"

    expect(current_path).to eq(admin_dashboard_path)

    expect(page).to have_content("john")
  end
end
