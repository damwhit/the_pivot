require "simplecov"
require "paperclip/matchers"
require "rspec/active_model/mocks"

module SpecHelpers
  def category1
    Category.find_or_create_by!(name: "festivals")
  end

  def user1
    User.create(
      first_name: "Dave",
      last_name: "Whit",
      email: "mustachefodays@example.com",
      password: "password",
      role: 0,
      fullname: "Dave Whit"
    )
  end

  def user2
    User.create(
      first_name: "Whitney",
      last_name: "Whit",
      email: "whit@example.com",
      password: "password",
      role: 0,
      fullname: "Whitney Whit"
    )
  end

  def category2
    Category.find_or_create_by!(name: "sports")
  end

  def venue1
    Venue.find_or_create_by!(name: "Outside", city: "Lima")
  end

  def venue2
    Venue.find_or_create_by!(name: "Stadium", city: "Denver")
  end

  def event1
    category1.events.find_or_create_by!(
      name: "Sun Festival",
      venue_id: venue1.id,
      time: "March 02, 2017 16:00",
      status: "active")
  end

  def make_listings_and_tickets
    listing1
    listing2
    ticket1
    ticket2
    ticket3
  end

  def listing1
    user1
    event1.listings.find_or_create_by!(user_id: User.first.id)
  end

  def listing2
    user2
    event1.listings.find_or_create_by!(user_id: User.last.id)
  end

  def ticket1
    listing1.tickets.find_or_create_by!(price: 800, seat: "10", row: "2")
  end

  def ticket2
    listing1.tickets.find_or_create_by!(price: 800, seat: "11", row: "2")
  end

  def ticket3
    listing2.tickets.find_or_create_by!(price: 1000, seat: "1", row: "1")
  end

  def make_events
    {
      event1: category1.events.find_or_create_by!(
        name: "Sun Festival",
        venue_id: venue1.id,
        time: "March 02, 2017 16:00",
        status: "active"),
      event2: category1.events.find_or_create_by!(
        name: "EDM Spectacular",
        venue_id: venue1.id,
        time: "November 20, 2020 18:00",
        status: "active"),
      event3: category2.events.find_or_create_by!(
        name: "Basketball",
        venue_id: venue2.id,
        time: "July 10, 2016 19:00",
        status: "active")
    }
  end

  def create_and_stub_admin
    admin = User.create(fullname: "John Adams",
                        email:      "admin@example.com",
                        password:   "password",
                        role: 1)
    ApplicationController.any_instance.stub(:current_user) { admin }
    admin
  end
end

SimpleCov.start("rails")

RSpec.configure do |config|
  config.include Paperclip::Shoulda::Matchers
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
