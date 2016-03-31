require 'rails_helper'

RSpec.describe OrderProcessor, :type => :model do
  include SpecHelpers

  it "gets the cart total" do
    contents = ([(Ticket.create(row: "2", seat: "5", price: 900).id), (Ticket.create(row: "2", seat: "6", price: 900).id)])
    cart = Cart.new(contents)
    order_processor = OrderProcessor.new(cart)
    expect(order_processor.cart_total).to eq(18)
  end

  it "processes current_user and creates an order" do
    contents = ([(Ticket.create(row: "2", seat: "5", price: 900).id), (Ticket.create(row: "2", seat: "6", price: 900).id)])
    cart = Cart.new(contents)
    order_processor = OrderProcessor.new(cart)
    current_user = user1
    params = { "stripeEmail" => "fodays@example.com",
               "stripeToken" => "tok_17v6vsCO47citMTS85s3gESi",
               "stripeShippingName" => "Sam Hello",
               "stripeShippingAddressLine1" => "1510 Blake St",
               "stripeShippingAddressCity" => "Denver",
               "stripeShippingAddressZip" => "80000",
               "stripeShippingAddressState" => "CO" }
    process = order_processor.process_current_user(params, current_user)
    expect(process.class).to eq(Order)
  end

end
