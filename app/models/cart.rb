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

  def double_click?(tickets)
    tickets.each do |ticket|
      if contents.include?(ticket.id)
        return true
      else
        return false
      end
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

  def remove_ticket_from_cart(id)
    contents.delete(id)
  end

  def update(params)
    contents[params[:id]] = params[:quantity].to_i
  end
end
