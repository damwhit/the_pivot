require "rails_helper"

RSpec.feature "AdminCanViewUsersByStatus", type: :feature do
  scenario "sees active users" do
    User.create(fullname: "Abe Lincoln",
                email: "honestabe@example.com",
                password: "password",
                id: 23)
    User.create(fullname: "Jane Adams",
                email: "janeadams@example.com",
                password: "password",
                status: "suspended",
                id: 5)
    User.create(fullname: "George Washington",
                email: "georgew@example.com",
                password: "password",
                id: 4)
    admin = User.create(fullname: "John Adams",
                        email:      "admin@example.com",
                        password:   "password",
                        role: 1,
                        id: 26)
    ApplicationController.any_instance.stub(:current_user) { admin }

    visit "/admin/dashboard"
    click_on "users"

    within(".users") do
      expect(first("tr")).to have_content "4"
      expect(first("tr")).to have_content "George Washington"
      expect(page).to_not have_content "5"
      expect(page).to_not have_content "Jane Adams"
      expect(page).to have_content "23"
      expect(page).to have_content "Abe Lincoln"
      expect(page).to have_content "26"
      expect(page).to have_content "John Adams"
    end
  end
end
