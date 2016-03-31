class Order < ActiveRecord::Base
  before_save :build_name
  belongs_to :user
  has_many :tickets

  validates :user_id, presence: true
  validates :fullname, presence:true
  validates :email, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :zip, presence: true

  scope :processed_orders, -> { where(status: "paid" || "completed") }

  scope :cancelled_orders, -> { where(status: "cancelled") }

  def build_name
    first_name = fullname.split[0]
    last_name = fullname.split[1..-1].join(" ")
  end

  def total
    tickets.map do |ticket|
      ticket.price
    end.inject(:+) / 100
  end

  def display_total
    "$#{total}"
  end

  def process(op_tickets)
    op_tickets.each do |ticket|
      tickets << ticket
    end
    process_stripe_payment
    self.update(order_total: total)
  end

  def set_ticket_status
    tickets.each do |ticket|
      Ticket.find(ticket.id).update(status: "purchased")
    end
  end

  def sort_tickets
    sorted = {}
    sorted[:upcoming] = tickets.select do |ticket|
      ticket.get_event.upcoming?
    end
    sorted[:past] = tickets.select do |ticket|
      ticket.get_event.past?
    end
    sorted[:cancelled] = tickets.select do |ticket|
      ticket.get_event.cancelled?
    end
    sorted
  end

  def date
    updated_at.strftime("%B %-d, %Y")
  end

  def process_stripe_payment
    customer = Stripe::Customer.create email: email,
                                       card: card_token
    Stripe::Charge.create customer: customer.id,
                          amount: total * 100,
                          description: id,
                          currency: 'usd'
  end
end
