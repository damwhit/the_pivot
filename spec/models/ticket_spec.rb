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

require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { should belong_to :listing }
  it do
    should validate_inclusion_of(:status).
      in_array(['active', 'purchased', 'reserved', 'inactive'])
  end

  it "formats the price" do
    ticket = Ticket.new(row: "5", seat: "2", price: 800)
    expect(ticket.format_price).to eq("$8")
  end

  it "formats the sum" do
    Ticket.create(row: "5", seat: "2", price: 100)
    Ticket.create(row: "5", seat: "3", price: 100)
    Ticket.create(row: "5", seat: "4", price: 100)
    expect(Ticket.all.formatted_sum).to eq("$3.00")
  end
end
