class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_tickets(tickets)
    tickets.each do |ticket|
      contents[ticket.id.to_s] ||= 0
      contents[ticket.id.to_s] += 1
    end
  end

  def count
    contents.values.sum
  end

  def tickets
    contents.map do |ticket_id, quantity|
      CartTicket.new(ticket_id, quantity)
    end
  end

  def empty?
    contents.empty?
  end

  def remove_product_from_cart(id)
    contents.reject! {|k| k == id}
  end

  def update(params)
    contents[params[:id]] = params[:quantity].to_i
  end
end
