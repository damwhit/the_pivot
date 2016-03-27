class CartTicket < SimpleDelegator
  attr_reader :listing, :quantity

  def initialize(ticket_id, quantity)
    @listing = Ticket.find(ticket_id)
    @quantity = quantity
    super(@listing)
  end

  def subtotal
    listing.price * quantity
  end

  def format_subtotal
    subtotal / 100
  end
end
