class Ticket < ActiveRecord::Base
  belongs_to :listing
  validates :row, presence: true
  validates :seat, presence: true
  validates :price, presence: true
  validates :status, inclusion: { in: %w(active purchased reserved),
      message: "%{value} is not a valid size" }

  scope :active, -> { where(status: "active") }

  def format_price
    "$#{price / 100}"
  end

  def self.formatted_sum
    "$#{sum(:price)}.00"
  end

  def get_event
    listing = Listing.find(listing_id)
    listing.event
  end
end
