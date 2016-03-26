require 'rails_helper'

RSpec.describe Listing, type: :model do
  include SpecHelpers
  it { should belong_to :event }
  it { should belong_to :user }
  it { should have_many :tickets }
  it {should validate_presence_of :user_id}
  it {should validate_presence_of :event_id}

  xit "should only have tickets of the same row" do
    user = user1
    event = event1
    ticket1 = Ticket.new(price: 800, seat: "10", row: "2")
    ticket2 = Ticket.new(price: 800, seat: "11", row: "2")
    listing = Listing.new(user_id: user.id, event_id: event.id)
    listing.tickets = [ticket1, ticket2]
    expect(listing.valid?).to be true
  end

  xit "should not have tickets of different rows" do
    user = user1
    event = event1
    ticket1 = Ticket.new(price: 800, seat: "10", row: "2")
    ticket2 = Ticket.new(price: 800, seat: "11", row: "5")
    listing = Listing.new(user_id: user.id, event_id: event.id)
    listing.tickets = [ticket1, ticket2]
    expect(listing.valid?).to be false
  end

  xit "should not have tickets of different prices" do
    user = user1
    event = event1
    ticket1 = Ticket.new(price: 800, seat: "10", row: "5")
    ticket2 = Ticket.new(price: 90000, seat: "11", row: "5")
    listing = Listing.new(user_id: user.id, event_id: event.id)
    listing.tickets = [ticket1, ticket2]
    expect(listing.valid?).to be false
  end
end
