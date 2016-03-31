require "rails_helper"

RSpec.describe Venue, type: :model do
  it { should have_many :events }
  it { should have_many :taggings }
end
