class EventsController < ApplicationController

  def index
    require_user
    @events = Event.upcoming_events.paginate(page:
                                             params[:page]).order(time:
                                                                  :asc)
  end

  def show
    require_user
    @event = Event.find(params[:id])
  end
end
