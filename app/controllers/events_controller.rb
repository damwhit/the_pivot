class EventsController < ApplicationController

  def index
    @events = Event.all.paginate(page: params[:page])
  end

  def show
    @event = Event.find(params[:id])
    @listings = @event.listings
  end
end
