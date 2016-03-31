# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role            :integer          default(0)
#  fullname        :string
#  status          :string           default("active")
#

require 'rails_helper'

RSpec.describe User, type: :model do
  include SpecHelpers
  it { should have_secure_password }
  it { should validate_presence_of :fullname}
  it { should validate_presence_of :email}
  it { should validate_presence_of :password_digest}
  it { should validate_presence_of :status }
  it { should validate_inclusion_of(:status).in_array(%w(active suspended)) }

  it { should have_many :orders }

  it "has a default status of active" do
    user = user1
    expect(user.status).to eq("active")
  end

  it "should filter by status" do
    user1

    User.create(
      first_name: "Heather",
      last_name: "Hi",
      email: "Heather@example.com",
      password: "password",
      role: 0,
      fullname: "Heather Hi",
      status: "suspended")

    expect(User.filter_by_status("all")).to eq(User.all)
    expect(User.filter_by_status("suspended")).to eq(User.where(status: "suspended"))
    expect(User.filter_by_status("active")).to eq(User.where(status: "active"))
  end

  it "should return full name" do
    user = user1
    expect(user.name).to eq("Dave Whit")
  end

  it "should get user's active events" do
    make_listings_and_tickets_dashboard

    user = User.last

    order = create_order(user)

    order.tickets << Ticket.find_by(seat: "10")

    expect(user.get_active_events).to eq([Event.first])
    expect(user.get_active_events).to_not eq([Event.last])
  end
end
