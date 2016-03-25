require 'simplecov'
require "paperclip/matchers"
require 'rspec/active_model/mocks'

module SpecHelpers
  def category1
    Category.find_or_create_by(name: "festivals")
  end

  def category2
    Category.find_or_create_by(name: "sports")
  end

  def venue1
    Venue.find_or_create_by(name: "Outside", city: "Lima")
  end

  def venue2
    Venue.find_or_create_by(name: "Stadium", city: "Denver")
  end

  def event
    category1.events.find_or_create_by(name: "Sun Festival", venue_id: venue.id, time: "8:00", status: "active")
  end

  def listing1
    event.find_or_create_by(price: 800, seat: "3", row: "6")
  end

  def listing2
    event.find_or_create_by(price: 1000, seat: "4", row: "2")
  end

  def make_events
    {
      event1: category1.events.create(name: "Sun Festival", venue_id: venue1.id, time: "16:00", status: "active", date: "March 02, 2017"),
      event2: category1.events.create(name: "EDM Spectacular", venue_id: venue1.id, time: "18:00", status: "active", date: "November 20, 2020"),
      event3: category2.events.create(name: "Basketball", venue_id: venue2.id, time: "19:00", status: "active", date: "July 10, 2016")
    }
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
