class Ticket < ActiveRecord::Base
  belongs_to :listing
  belongs_to :order
  validates :row, presence: true
  validates :seat, presence: true
  validates :price, presence: true
  validates :status, inclusion: { in: %w(active purchased reserved inactive),
      message: "%{value} is not a valid status" }

  scope :active, -> { where(status: "active") }

  def format_price
    "$#{price / 100}"
  end

  def self.formatted_sum
    "$#{(sum(:price))/100}.00"
  end

  def get_event
    listing = Listing.find(listing_id)
    listing.event
  end

  def event_status
    get_event.status
  end
end
