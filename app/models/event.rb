class Event < ActiveRecord::Base
  belongs_to :category
  belongs_to :venue
  has_many :listings

  # validates :name, presence: true, uniqueness: true
  # validates :category, presence: true
  # validates :venue, presence: true

  scope :upcoming_events, -> do
    where("time >= ? AND status != 'cancelled'", Time.zone.now.beginning_of_day)
  end
  scope :past_events, -> do
    where("time <= ? AND status != 'cancelled'", Time.zone.now.beginning_of_day)
  end
  scope :cancelled, -> { where(status: "cancelled") }

  has_attached_file :image,
      styles: { index: '275x175>', show: '550x350<', small: '137.5x87.5>' },
      default_url: "logo.ico"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def format_date
    time.strftime("%a,%e %b")
  end

  def format_time
    time.strftime("%I:%M%P")
  end

  def time_venue
    "#{format_time} at #{venue.name}"
  end

  def format_location
    "#{venue.city}, #{venue.state}"
  end

  def self.active_index
    where(inactive: false).order(:name)
  end

  def self.inactive_index
    where(inactive: true).order(:name)
  end

  def inactive?
    inactive
  end

  def self.category_distribution
    group(:category).count.map { |k, v| [k.name, v] }
  end

  def self.filter_by_status(status)
    status ||= "upcoming_events"
    send(status)
  end
end
