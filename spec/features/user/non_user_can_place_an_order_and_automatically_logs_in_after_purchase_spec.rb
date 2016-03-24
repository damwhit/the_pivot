require "rails_helper"

RSpec.feature "NonUserCanPlaceOrder", type: :feature do
  scenario "non-user places order and views previous orders" do
    pending
    # guest user can still buy them tickets
    category = Category.create(name: "coffee")
    product = category.products.create(name:"Ethiopian", price:1500,
    description:"Ethiopian coffee is super good" )

    visit "/products/#{product.id}"
    click_on "Add to cart"

    click_on "cart"

    click_on "Checkout"

    expect(current_path).to eq("/orders/login")

    fill_in "fullname", with: "John Adams"
    fill_in "email", with: "test@test.com"
    fill_in "password", with: "password"


    click_on "continue"
    expect(page).to have_content("$15")

  end
end
