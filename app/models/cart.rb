class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || []
  end

  def add_tickets(tickets)
    tickets.each do |ticket|
      contents << ticket.id
    end
  end

  def count
    contents.count
  end

  def tickets
    contents.map do |ticket_id|
      CartTicket.new(ticket_id)
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
