# == Schema Information
#
# Table name: events
#
#  id                 :integer          not null, primary key
#  name               :string
#  category_id        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  time               :datetime
#  status             :string           default("upcoming")
#  venue_id           :integer
#

require "rails_helper"

RSpec.describe Event, type: :model do
  include SpecHelpers
  it { should belong_to :venue }
  it { should belong_to :category }
  it { should have_many :listings }

  context "formats time" do
    it "formats the time" do
      event = make_events[:event1]
      expect(event.format_time).to eq("04:00pm")
    end
  end

  context "formats date" do
    it "formats the date" do
      event = make_events[:event1]
      expect(event.format_date).to eq("Thu, 2 Mar")
    end
  end
end
