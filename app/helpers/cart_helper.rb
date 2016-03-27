module CartHelper
  def cart_total(listings)
    raw_cart_total(listings) / 100
  end

  def raw_cart_total(listings)
    listings.map do |listing|
      ticket_price = listing.tickets.first.price
      ticket_price * listing.count_tickets
    end.reduce(:+)
  end
end
