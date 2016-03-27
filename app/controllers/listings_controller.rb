class ListingsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @listing = Listing.new(event_id: Event.find(params[:event_id]).id,
                           user_id: current_user.id)
    seat_params.each do |_k, v|
      @listing.tickets << Ticket.create(price: ticket_params[:price],
                                        row: ticket_params[:row],
                                        seat: v)
    end
    if @listing.save
      flash[:info] = "Your tickets are up for sale!"
      redirect_to user_dashboard_path
    else
      flash.now[:alert] = "Sorry, boss lolololololololol.  Something went wrong ;>(... Please try again."
      render :new
    end
  end

  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
  end

  private

    def ticket_params
      params.permit(:price, :row)
    end

    def seat_params
      params.require(:seat).permit("0", "1", "2", "3",
                                   "4", "5", "7", "8", "9")
    end
end
