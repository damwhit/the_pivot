require "rails_helper"

RSpec.describe Event, type: :model do
  include SpecHelpers
  it { should belong_to :venue }
  it { should belong_to :category }
  it { should have_many :listings }
  # it { should validate_presence_of :name }
  # it { should validate_presence_of :category }
  # it { should validate_presence_of :venue }

  context "formats time" do
    it "formats the time" do
      event = make_events[:event1]
      expect(event.format_time).to eq("4:00 pm")
    end
  end

  context "formats date" do
    it "formats the date" do
      event = make_events[:event1]
      expect(event.format_date).to eq("Thu, 2 Mar")
    end
  end
end
