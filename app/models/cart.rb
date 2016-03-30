class Cart
  attr_accessor :contents

  def initialize(initial_contents)
    @contents = initial_contents || []
  end

  def add_tickets(tickets)
    tickets.each do |ticket|
      contents << ticket.id
      Ticket.find(ticket.id).update(status: "reserved")
    end
  end

  def count
    contents.count
  end

  def empty_cart
    contents.each do |ticket_id|
      Ticket.find(ticket_id).update(status: "active")
    end
    self.contents = []
  end

  def tickets
    contents.map do |ticket_id|
      Ticket.find(ticket_id)
    end
  end

  def empty?
    contents.empty?
  end

  def remove_ticket_from_cart(id)
    contents.delete(id)
    Ticket.find(id).update(status: "active")
  end

  def update(params)
    contents[params[:id]] = params[:quantity].to_i
  end
end
