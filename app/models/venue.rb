class Venue < ActiveRecord::Base
  has_many :events

  def upcoming_events
    events.upcoming_events
  end
end
