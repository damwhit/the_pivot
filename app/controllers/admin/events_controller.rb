class Admin::EventsController < Admin::BaseController
  def index
    @events = Event.filter_by_status(params[:status])
  end
end
