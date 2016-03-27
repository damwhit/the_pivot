class CartTicket < SimpleDelegator
  attr_reader :listing

  def initialize(ticket_id, quantity)
    @listing = Ticket.find(ticket_id)
    super(@listing)
  end

  def subtotal
    listing.price * quantity
  end

  def format_subtotal
    subtotal / 100
  end
end
