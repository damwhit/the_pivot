# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  street      :string
#  unit        :string
#  city        :string
#  state       :string
#  zip         :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  first_name  :string
#  last_name   :string
#  email       :string
#  status      :string           default("paid")
#  fullname    :string
#  card_token  :string
#  order_total :integer
#

require 'rails_helper'

RSpec.describe Order, :type => :model do
  include SpecHelpers

  it { should validate_presence_of :user_id}
  it { should validate_presence_of :fullname}
  it { should validate_presence_of :email}
  it { should validate_presence_of :street}
  it { should validate_presence_of :city}
  it { should validate_presence_of :zip}

  it { should belong_to :user }

  it "builds the name" do
    user = user1
    order = create_order(user)
    expect(order.first_name).to eq("jonathon")
    expect(order.last_name).to eq("adams")
  end

  it "totals the order price" do
    user = user1
    order = create_order(user)
    order.tickets << Ticket.new(price: 800, seat: "10", row: "5")
    order.tickets << Ticket.new(price: 800, seat: "11", row: "5")
    expect(order.total).to eq(16)
  end

  it "formats the date" do
    user = user1
    order = create_order(user)
    expect(order.date).to eq("March 31, 2016")
  end

  it "sets ticket status" do
    user = user1
    order = create_order(user)
    ticket = Ticket.new(price: 800, seat: "10", row: "5")
    order.tickets << ticket
    order.set_ticket_status
    expect(Ticket.find_by(seat: "10").status).to eq("purchased")
  end
end
