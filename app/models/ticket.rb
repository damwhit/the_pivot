class Ticket < ActiveRecord::Base
  belongs_to :listing
  belongs_to :order
  validates :row, presence: true
  validates :seat, presence: true
  validates :price, presence: true
  # validates :seat, uniqueness: { scope: [:event_id, :row] }
  validates :status, inclusion: { in: %w(active purchased reserved),
      message: "%{value} is not a valid size" }

  scope :active, -> { where(status: "active") }

  def format_price
    "$#{unformatted_price}"
  end

  def unformatted_price
    price / 100
  end

  def self.formatted_sum
    "$#{(sum(:price)) / 100}.00"
  end

  def get_event
    listing = Listing.find(listing_id)
    listing.event
  end

  def event_status
    get_event.status
  end
end
