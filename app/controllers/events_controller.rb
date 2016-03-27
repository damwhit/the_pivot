class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = "Sun Festival"
  end
end
