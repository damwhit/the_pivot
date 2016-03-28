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
      @cart.add_tickets(tickets)
      session[:cart] = @cart.contents
      flash[:info] = "listing number #{listing.id} added to cart!"
      redirect_to "/#{listing.listing_category}"
    end
  end

  def destroy
    product = find_product(params[:id])
    @cart.remove_product_from_cart(product.id.to_s)
    flash[:alert] = "You have removed #{view_context.link_to product.name, product_path(product.id)} from your cart."
    if @cart.empty?
      redirect_to root_path
    else
      redirect_to cart_path
    end
  end

  def update
    @cart.update(params)
    redirect_to cart_path
  end

  private

  def find_product(id)
    Product.find(id)
  end
end
