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

class OrderListing < ActiveRecord::Base
  belongs_to :listing
  belongs_to :order
end
