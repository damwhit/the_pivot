module CartHelper
  def cart_total(tickets)
    raw_cart_total(tickets) / 100
  end

  def raw_cart_total(tickets)
    tickets.inject(0) { |sum, ticket| sum + ticket.price }
  end

  def get_tickets(seats)
    seats.map do |seat|
      Ticket.find_by(seat: seat)
    end
  end
end
