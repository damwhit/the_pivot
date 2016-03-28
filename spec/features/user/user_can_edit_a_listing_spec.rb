require "rails_helper"

RSpec.feature "UserAddsListingForAnEvent", type: :feature do
  include SpecHelpers
  def setup
    @user = user1
    @event = event1
    @listing = make_listing
  end

  scenario "user edits a listing", js: true do
    setup

    visit "/"
    click_on "sign in"
    fill_in "email", with: @user.email
    fill_in "password", with: @user.password
    click_on "login"

    click_on "my listings"

    expect(current_path).to eq("/users/#{@user.id}/listings")

    expect(page).to have_content(@listing.event.name.to_s)

  end
#   As a logged in user
# When I visit ‘/users/:user_id/dashboard’
# And click on ‘My listings’
# my current page should be '/user/:user_id/listings'
# I see all listings paginated and ordered by closest to current date.
# I fill in the ticket info Row, seat number and the price for the listing I would like to edit.
# And I click on "edit listing" next to the listing that I want to edit.
# I should see 'Your listing#{name} has been updated!'
# And I should see not see the updated listing info on my dashboard
# And I should not see the non-updated info on my dashboard
end
