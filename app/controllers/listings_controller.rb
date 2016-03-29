# == Schema Information
#
# Table name: listings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
    require_user
    @listings = Listing.all
  end

  def show
    require_user
    @listing = Listing.find(params[:id])
  end

  def update
    #delete all active tickets
    #recreate new active tickets
    @listing = Listing.find(params[:id])
    @listing.destroy_active_tickets
    params[:seat].each do |seat_number|
      @listing.tickets << Ticket.create(price: ticket_params[:price],
                                        row: ticket_params[:row],
                                        seat: seat_number)
    end
    if @listing.save
      flash[:info] = "You're listing has been updated"
      redirect_to user_dashboard_path
    else
      flash.now[:alert] = "Sorry, boss lolololololololol.  Something went wrong ;>(... Please try again."
      render :index
    end
    require "pry"; binding.pry
  end

  def destroy
    require "pry"; binding.pry
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
