class Admin::EventsController < Admin::BaseController
  def index
    @events = Event.filter_by_status(params[:status])
    @venues = Venue.all
    @categories = Category.all
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

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:info] = "Updated event: #{@event.name}"
      redirect_to admin_events_path
    else
      flash.now[:error] = "Sorry, could not create that event. Please try again"
      render :new
    end
  end

  def cancel
    @event = Event.find(params[:id])
    if @event.update(status: "cancelled")
      flash[:info] = "#{@event.name} has been cancelled"
      redirect_to admin_events_path(status: 'cancelled')
    end
  end

  private

    def event_params
      params[:event][:time] = parse_date_time(params)
      params.require(:event).permit(:name, :venue_id, :time, :category_id, :status)
    end

    def parse_date_time(params)
      merged = "#{params[:date]} #{params[:event][:time]}".downcase
      if merged.include?("-")
        DateTime.parse(merged).strftime("%Y-%m-%d %H:%M:%S")
      elsif merged.include?("m")
        DateTime.strptime(merged, "%m/%d/%Y %I:%M %p").
                 strftime("%Y-%m-%d %H:%M:%S")
      else
        DateTime.strptime(merged, "%m/%d/%Y %H:%M:%S").
                 strftime("%Y-%m-%d %H:%M:%S")
      end
    end
end
