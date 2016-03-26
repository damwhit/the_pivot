require "rails_helper"

RSpec.feature "AdminCanChangeUserStatuses", type: :feature do
  before(:each) do
    @user = User.create(fullname: "Abe Lincoln",
                        email: "honestabe@example.com",
                        password: "password")
    @admin = User.create(fullname: "John Adams",
                         email:      "admin@example.com",
                         password:   "password",
                         role: 1)
    ApplicationController.any_instance.stub(:current_user) { @admin }
  end

  scenario "see user on suspended users page" do
    visit "/admin/dashboard"
    click_on "users"

    within("#user-#{@user.id}") do
      select "suspended", from: "user_status"
      click_on "update status"
    end

    expect(page).to have_content "Abe Lincoln's status has been changed to suspended"
    within(".users") do
      expect(page).to_not have_content @user.name
      expect(page).to_not have_content @user.id
    end

    click_on "suspended users"
    within(".users") do
      expect(page).to have_content @user.name
      expect(page).to have_content @user.id
    end
  end
end
