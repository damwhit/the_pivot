require "rails_helper"

RSpec.feature "AdminCanViewUsersByStatus", type: :feature do
  scenario "sees active users" do
    User.create(fullname: "John Adams",
                email: "johnadams@example.com",
                password: "password",
                id: 25)
    User.create(fullname: "Jane Adams",
                email: "janeadams@example.com",
                password: "password",
                status: "suspended",
                id: 5)
    User.create(fullname: "George Washington",
                email: "georgew@example.com",
                password: "password",
                id: 4)
    create_and_stub_admin

    visit "/admin/dashboard"
    click on "users"

    within(".users") do
      expect(first("td")).to have_content "George Washington"
      expect(first("td")).to have_content "4"
      expect(page).to_not have_content "Jane Adams"
      expect(page).to_not have_content "5"
      expect(page).to_not have_content "John Adams"
      expect(page).to_not have_content "25"
    # I see only active users and they are sorted by their ID number
    end
  end
end
