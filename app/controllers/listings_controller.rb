class ListingsController < ApplicationController
  before_action :require_user

  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @listing = Listing.new(event_id: Event.find(params[:event_id]).id,
                           user_id: current_user.id)
    seat_params.each do |seat_number|
      @listing.tickets << Ticket.create(price: ticket_params[:price],
                                        row: ticket_params[:row],
                                        seat: seat_number)
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
    @listings = current_user.listings
  end

  def show
    @listing = current_user.listings.find(params[:id])
  end

  def update
    @listing = current_user.listings.find(params[:id])
    @listing.destroy_active_tickets
    params[:seat].each do |seat_number|
      @listing.tickets << Ticket.create(price: ticket_params[:price],
                                        row: ticket_params[:row],
                                        seat: seat_number)
    end
    if @listing.save
      flash[:info] = "Listing number #{@listing.id} has been updated!"
      redirect_to user_dashboard_path
    else
      flash.now[:alert] = "Sorry, boss lolololololololol.  Something went wrong ;>(... Please try again."
      render :index
    end
  end

  def destroy
    @listing = current_user.listings.find(params[:id])
    @listing.destroy_active_tickets
    if @listing.has_tickets
      @listing.update(status: "inactive")
      flash[:alert] = "Listing #{@listing.id} has been deactivated"
      redirect_to user_dashboard_path
    else
      @listing.destroy
      flash[:alert] = "Listing #{@listing.id} has been cancelled"
      redirect_to user_dashboard_path
    end
  end

  private

    def ticket_params
      params.permit(:price, :row)
    end

    def seat_params
      params.require(:seat)
    end
end
