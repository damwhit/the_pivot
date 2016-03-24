require "rails_helper"

RSpec.feature "UserAddsListingToCart", type: :feature do
  scenario "user adds listing to cart" do
    
  end
end

# As a visitor
# When I view an individual event
# I see a list of all the tickets associated with the event
# When I find the ticket I want
# And then click on “Add to cart”
# My current path should be  ‘/category_name’
# And I should see a flash message that says the ticket has been added to the cart
# When I click on the cart icon
# My current path should be ‘/cart’
# And I should see the ticket I added with the order subtotal
