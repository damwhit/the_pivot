class EventsController < ApplicationController

  def index
    @events = Event.where("time >= ?", Time.zone.now.beginning_of_day).paginate(page: params[:page]).order(time: :asc)
  end

  def show
    @event = Event.find(params[:id])
    @listings = @event.listings
  end
end
