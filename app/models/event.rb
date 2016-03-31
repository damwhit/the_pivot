class Event < ActiveRecord::Base
  belongs_to :category
  belongs_to :venue
  has_many :listings
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  validates :name, presence: true
  validates :category, presence: true
  validates :venue, presence: true
  validates :status, presence: true, inclusion: { in: %w(active cancelled upcoming),
                                                  message: "%{value} is not a valid status" }

  scope :upcoming_events, -> do
    where("time >= ? AND status != 'cancelled'", Time.zone.now.beginning_of_day).order(:time)
  end
  scope :past_events, -> do
    where("time <= ? AND status != 'cancelled'", Time.zone.now.beginning_of_day)
  end
  scope :cancelled, -> { where(status: "cancelled") }

  has_attached_file :image,
      styles: { index: '275x175>', show: '550x350<', small: '137.5x87.5>' },
      default_url: "logo.ico"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def upcoming?
    Time.zone.now < time && status != "cancelled"
  end

  def past?
    Time.zone.now > time && status != "cancelled"
  end

  def cancelled?
    status == "cancelled"
  end

  def format_date
    time.strftime("%a, %-d %b %Y")
  end

  def format_time
    time.strftime("%-l:%M %P")
  end

  def time_venue
    "#{format_time} at #{venue.name}"
  end

  def format_location
    "#{venue.city}, #{venue.state}"
  end

  def status_formatted
    return "upcoming" if upcoming?
    return "cancelled" if cancelled?
    "past"
  end

  def deactivate_listings
    listings.each { |listing| listing.deactivate }
  end

  def self.filter_by_status(status)
    status ||= "upcoming_events"
    send(status)
  end
end
