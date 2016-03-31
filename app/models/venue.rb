class Venue < ActiveRecord::Base
  has_many :events
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  def upcoming_events
    events.upcoming_events
  end
end
