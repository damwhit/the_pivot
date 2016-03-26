class Listing < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :tickets
  #validates :tickets, presence: true
  validates :tickets, presence: true, if: :row_matches?
  validates :user_id, presence: true
  validates :event_id, presence: true
  #validate :tickets, :row_matches?

  def row_matches?
    return false if tickets.empty?
    row = tickets.first.row
    tickets.all? do |ticket|
      ticket.row == row
    end
  end

  def price_matches?
    return false if tickets.empty?
    row = tickets.first.price
    tickets.all? do |ticket|
      ticket.price == price
    end
  end
end
