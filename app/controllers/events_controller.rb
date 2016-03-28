class EventsController < ApplicationController

  def index
    @events = Event.upcoming_events.paginate(page:
                                             params[:page]).order(time:
                                                                  :asc)
  end

  def show
    @event = Event.find(params[:id])
  end
end
