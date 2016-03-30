class Order < ActiveRecord::Base
  before_save :build_name
  belongs_to :user
  has_many :order_tickets
  has_many :tickets, through: :order_tickets
  has_many :comments

  validates :user_id, presence: true
  validates :fullname, presence:true
  validates :email, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :zip, presence: true

  scope :processed_orders, -> { where(status: "paid" || "completed") }

  scope :cancelled_orders, -> { where(status: "cancelled") }

  def self.total_revenue
    processed_orders.sum(:order_total)
  end

  def self.daily_average_revenue
    return if Order.count == 0
    total_revenue / processed_orders.group(:created_at).count.length
  end

  def self.weekly_average_revenue
    return if Order.count == 0
    total_revenue / processed_orders.group_by_week(:created_at).count.length
  end

  def self.search(search)
    where('first_name || last_name || fullname ILIKE ?', "%#{search}%").uniq
  end

  def self.search_by_date(search)
    date = Date.parse(search)
    where(updated_at: date.beginning_of_day..date.end_of_day)
  end

  def build_name
    self.first_name = fullname.split[0]
    self.last_name = fullname.split[1..-1].join(" ")
  end

  def total
    order_tickets.map do |order_ticket|
      order_ticket.total
    end.inject(:+) / 100
  end

  def display_total
    "$#{total}"
  end

  def process(tickets)
    tickets.each do |ticket|
      order_tickets.create(ticket_id: ticket.id)
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
    sorted ={}
    sorted[:upcoming] = tickets.find_all do |ticket|
      ticket.event_status == "active"
    end
    sorted[:past] = tickets.find_all do |ticket|
      ticket.event_status == "inactive"
    end
    sorted[:cancelled] = tickets.find_all do |ticket|
      ticket.event_status == "cancelled"
    end
    sorted
  end

  def product_quantity
    order_products.count
  end

  def name
    "#{first_name} #{last_name}"
  end

  def self.by_date
    order(updated_at: :desc)
  end

  def date
    updated_at.strftime("%B %-d, %Y")
  end

  def self.top_state
    return if Order.count == 0
    group(:state).count.sort_by { |state, n| n }.last[0]
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
