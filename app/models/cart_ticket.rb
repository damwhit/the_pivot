class CartTicket < SimpleDelegator
  attr_reader :listing

  def initialize(ticket_id)
    @ticket = Ticket.find(ticket_id)
    super(@ticket)
  end

  def subtotal
    listing.price * quantity
  end

  def format_subtotal
    subtotal / 100
  end
end