module CartHelper
  def cart_total(tickets)
    raw_cart_total(tickets) / 100
  end

  def raw_cart_total(tickets)
    tickets.map do |ticket|
      ticket.price
    end.reduce(:+)
  end
end
