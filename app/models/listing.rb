class Listing < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :tickets, dependent: :destroy

  validates :tickets, presence: true
  validates :user_id, presence: true
  validates :event_id, presence: true

  validate :ticket_row_matches?, :ticket_price_matches?

  scope :inactive, -> { where(status: "inactive") }

  def ticket_row_matches?
    return unless has_tickets?
    row = tickets.first.row
    same_row = tickets.all? do |ticket|
      ticket.row == row
    end
    unless same_row
      errors.add(:tickets, "must have the same row")
    end
  end

  def has_tickets?
    if tickets.empty?
      errors.add(:listing, "must have at least one ticket")
      false
    else
      true
    end
  end

  def ticket_price_matches?
    return unless has_tickets?
    price = tickets.first.price
    same_price = tickets.all? do |ticket|
      ticket.price == price
    end
    unless same_price
      errors.add(:tickets, "must have the same price")
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

  def view_unformatted_price
    tickets.first.unformatted_price
  end

  def listing_category
    event.category.name
  end

  def seats
    tickets.where(status: "active").pluck(:seat)
  end

  def format_date
    updated_at.strftime("%Y-%m-%d")
  end

  def destroy_active_tickets
    tickets.active.destroy_all
  end

  def has_tickets
    tickets.any?
  end

  def active?
    status == "active"
  end

  def deactivate
    update(status: "inactive")
    tickets.each do |ticket|
      ticket.update(status: "inactive") if ticket.status == "active"
    end
  end
end
