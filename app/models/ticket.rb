class Ticket < ActiveRecord::Base
  belongs_to :listing
  validates :row, presence: true
  validates :seat, presence: true
  validates :price, presence: true

  def format_price
    "$#{price / 100}"
  end

  def self.formatted_sum
    "$#{sum(:price)}.00"
  end
end
