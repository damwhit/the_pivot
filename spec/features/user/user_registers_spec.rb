require "rails_helper"

RSpec.feature "UserRegisters", type: :feature do
  scenario "user registers" do
    visit root_path
    click_on "sign in"

    click_on "signup"

    expect(current_path).to eq(new_user_path)

    fill_in "user[fullname]", with: "Bob"
    fill_in "Password", with: "password"
    fill_in "Email", with: "bob@example.com"
    click_on "signup"

    expect(current_path).to eq(root_path)

    within("div .alert") do
      expect(page).to have_content("Hey Bob, welcome to ticketcacher.")
    end
    within(".sidebar-nav") do
      expect(page).to have_content("listings")
    end
  end
end

# As a visitor
# When I click on the arrow icon
# I should see the login page
# When I click on ‘signup’
# My current path should be ‘/users/new’
# I enter my name, email, and password
# And press ‘Submit’
# I should be redirected to the home page
# And see a flash message that welcomes me to the site
