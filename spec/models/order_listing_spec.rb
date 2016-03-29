# == Schema Information
#
# Table name: order_listings
#
#  id         :integer          not null, primary key
#  listing_id :integer
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe OrderTicket, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
