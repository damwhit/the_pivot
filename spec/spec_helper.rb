require 'simplecov'
require "paperclip/matchers"
require 'rspec/active_model/mocks'

SimpleCov.start("rails")

module SpecHelpers


  def category1
    Category.find_or_create_by(name:"Festivals") #prolly will need find or create by
  end

  def category2
    Category.find_or_create_by(name:"Sports")
  end

  def venue1
    Venue.find_or_create_by(name: "Outside", city: "Lima")
  end

  def venue2
    Venue.find_or_create_by(name: "Stadium", city: "Denver")
  end

  def event
    category1.events.find_or_create_by(name: "Sun Festival", image_file_path: 'http://mortenbentzon.com/wp-content/uploads/2014/07/midnightsun_blog161-e1406761557421.jpg', venue_id: venue.id, time: "8:00", status: "active")
  end

  def listing1
    event.find_or_create_by(price: 800, seat: "3", row: "6")
  end

  def listing2
    event.find_or_create_by(price: 1000, seat: "4", row: "2")
  end

  def make_events
    {
      event1: category1.events.create(name: "Sun Festival", image_file_path: 'http://mortenbentzon.com/wp-content/uploads/2014/07/midnightsun_blog161-e1406761557421.jpg', venue_id: venue1.id, time: "8:00", status: "active"),
      event2: category.events.create(name: "EDM Spectacular", image_file_path: 'http://mortenbentzon.com/wp-content/uploads/2014/07/midnightsun_blog161-e1406761557421.jpg', venue_id: venue1.id, time: "7:00", status: "active"),
      event3: category2.events.create(name: "Basketball", image_file_path: 'http://a57.foxnews.com/global.fncstatic.com/static/managed/img/fn-latino/sports/660/371/us%20beats%20brazil.jpg?ve=1&tl=1', venue_id: venue2.id, time: "8:00", status: "active")
    }
  end
end

RSpec.configure do |config|
  config.include Paperclip::Shoulda::Matchers
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
