class Listing < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :tickets
  # validates :tickets, presence: true
  validates :tickets, presence: true, if: :row_matches?
  validates :user_id, presence: true
  validates :event_id, presence: true
  # validate :tickets, :row_matches?

  def row_matches?
    return false if tickets.empty?
    row = tickets.first.row
    tickets.all? do |ticket|
      ticket.row == row
    end
  end

  def price_matches?
    return false if tickets.empty?
    price = tickets.first.price
    tickets.all? do |ticket|
      ticket.price == price
    end
  end

  def view_row
    tickets.first.row
  end

  def count_tickets
    tickets.count
  end

  def view_price
    tickets.first.format_price
  end

  def listing_category
    event.category.name
  end

  def seats
    tickets.map do |ticket|
      if ticket.status == "active"
        ticket.seat
      end
    end
  end
end

# <div class="col-xs-3 col-sm-3 col-md-3 form-inline">
#   quantity: <%= select_tag "quantity", options_for_select([*1..10]), {class: "form-control form-control-sm"} %>
# </div>
