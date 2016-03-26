class Admin::EventsController < Admin::BaseController
  def index
  end

  def new
    @event = Event.new
    @venues = Venue.all
  end
end
