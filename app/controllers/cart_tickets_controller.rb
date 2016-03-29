class CartTicketsController < ApplicationController
  include CartHelper
  def create
    listing = Listing.find(params[:listing_id])
    seats = params[:seats]
    if seats.nil?
      flash[:alert] = "please select a seat"
      @event = listing.event
      render "events/show"
    else
      tickets = get_tickets(seats, listing)
      if @cart.double_click?(tickets)
        flash[:info] = "You have already added that ticket to the cart. Please try again"
        redirect_to event_path(listing.event)
      else
        @cart.add_tickets(tickets)
        session[:cart] = @cart.contents
        flash[:info] = "listing number #{listing.id} added to cart!"
        redirect_to "/#{listing.listing_category}"
      end
    end
  end

  def destroy
    ticket = find_ticket(params[:id])
    @cart.remove_ticket_from_cart(ticket.id)
    flash[:alert] = "You have removed #{view_context.link_to ticket.get_event.name, event_path(ticket.get_event.id)} from your cart."
    if @cart.empty?
      redirect_to root_path
    else
      redirect_to cart_path
    end
  end

  private

  def find_ticket(id)
    Ticket.find(id)
  end
end
