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
end
