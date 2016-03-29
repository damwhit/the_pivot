class Admin::EventsController < Admin::BaseController
  def index
    @events = Event.filter_by_status(params[:status])
  end

  def new
    @event = Event.new
    @venues = Venue.all
    @categories = Category.all
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:info] = "Created new event: #{@event.name}"
      redirect_to event_path(@event.id)
    else
      flash.now[:error] = "Sorry, could not create that event. Please try again"
      render :new
    end
  end

  private

    def event_params
      merged = "#{params[:date]} #{params[:event][:time]}"
      params[:event][:time] = DateTime.strptime(merged, "%m/%d/%Y %I:%M %p").
                                       strftime("%Y-%m-%d %H:%M:%S")
      params.require(:event).permit(:name, :venue_id, :time, :category_id)
    end
end
