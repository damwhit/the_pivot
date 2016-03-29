class CartTicket < SimpleDelegator

  def initialize(ticket_id)
    @ticket = Ticket.find(ticket_id)
    super(@ticket)
  end
end
