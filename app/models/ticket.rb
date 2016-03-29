# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  price      :integer
#  seat       :string
#  row        :string
#  listing_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string           default("active")
#

class Ticket < ActiveRecord::Base
  belongs_to :listing
  validates :row, presence: true
  validates :seat, presence: true
  validates :price, presence: true

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
