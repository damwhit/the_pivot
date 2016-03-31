# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  street      :string
#  unit        :string
#  city        :string
#  state       :string
#  zip         :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  first_name  :string
#  last_name   :string
#  email       :string
#  status      :string           default("paid")
#  fullname    :string
#  card_token  :string
#  order_total :integer
#

require 'rails_helper'

RSpec.describe Order, :type => :model do

  it { should validate_presence_of :user_id}
  it { should validate_presence_of :fullname}
  it { should validate_presence_of :email}
  it { should validate_presence_of :street}
  it { should validate_presence_of :city}
  it { should validate_presence_of :zip}

  it { should belong_to :user }

end
