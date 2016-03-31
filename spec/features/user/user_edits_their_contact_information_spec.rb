require "rails_helper"
RSpec.feature "UserEditsTheirContactInformation", type: :feature do
  include SpecHelpers
  scenario "user edits their name and email" do
    user = User.create(
      first_name: "Dave",
      last_name: "Whit",
      email: "mustachefodays@example.com",
      password: "password",
      role: 0,
      fullname: "Dave Whit")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    expect(page).to have_content(user.fullname)

    click_on "edit contact info"

    expect(current_path).to eq(edit_user_path)

    fill_in "Fullname", with: "I am the coolest"
    fill_in "Email", with: "mymustacheisgone@example.com"
    click_on "update"

    expect(current_path).to eq(user_dashboard_path)

    expect(user.fullname).to eq("I am the coolest")
    expect(user.email).to eq("mymustacheisgone@example.com")

    expect(page).to have_content(user.fullname)
    expect(page).to have_content(user.email)
    expect(page).to have_content("yo info has been updated!")
  end

  scenario "user leaves a field back and the edit page is rendered" do
    user = User.create(
      first_name: "Dave",
      last_name: "Whit",
      email: "mustachefodays@example.com",
      password: "password",
      role: 0,
      fullname: "Dave Whit")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    click_on "edit contact info"

    fill_in "Fullname", with: "I am the coolest"
    fill_in "Email", with: " "
    click_on "update"

    expect(page).to have_content("please enter all information")
  end
end
