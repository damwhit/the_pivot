require "rails_helper"

RSpec.feature "AdminCanViewUsersByStatus", type: :feature do
  before(:each) do
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
    @admin = User.create(fullname: "John Adams",
                         email:      "admin@example.com",
                         password:   "password",
                         role: 1,
                         id: 26)
    ApplicationController.any_instance.stub(:current_user) { @admin }
  end

  scenario "sees active users by default ordered by id" do
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

  scenario "sees suspended users" do
    visit "/admin/dashboard"
    click_on "users"
    click_on "suspended users"

    within(".users") do
      expect(page).to have_content "5"
      expect(page).to have_content "Jane Adams"
      expect(page).to_not have_content "4"
      expect(page).to_not have_content "George Washingto_notn"
      expect(page).to_not have_content "23"
      expect(page).to_not have_content "Abe Lincoln"
      expect(page).to_not have_content "26"
      expect(page).to_not have_content "John Adams"
    end
  end

  scenario "sees all users" do
    visit "/admin/dashboard"
    click_on "users"
    click_on "all users"

    within(".users") do
      expect(page).to have_content "4"
      expect(page).to have_content "George Washington"
      expect(page).to have_content "5"
      expect(page).to have_content "Jane Adams"
      expect(page).to have_content "23"
      expect(page).to have_content "Abe Lincoln"
      expect(page).to have_content "26"
      expect(page).to have_content "John Adams"
    end
  end

  scenario "sees active users" do
    visit "/admin/dashboard"
    click_on "users"
    click_on "active users"

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
