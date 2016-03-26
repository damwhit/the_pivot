class Ticket < ActiveRecord::Base
  belongs_to :listing
  validates :row, presence: true
  validates :seat, presence: true
  validates :price, presence: true

  def format_price
    "$#{price.to_i / 100}"
  end
end
